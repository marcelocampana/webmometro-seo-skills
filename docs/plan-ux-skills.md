# Plan: Skills UX — Site y Page

**Estado**: Pendiente de implementación
**Fecha de diseño**: 2026-03-19

## Contexto

El equipo necesita informes de experiencia de usuario orientados a **diseño**, no a SEO.
Los skills SEO existentes usan GA4 y Clarity de forma marginal (solo Clarity en page-audit, GA4 casi sin usar). Se crearán dos skills nuevos que ponen estos datos en el centro, generando informes accionables para equipos de diseño y UX.

El usuario confirmó:
- Nombre sin "report" → `webmometro-ux-site` y `webmometro-ux-page`
- Leen `site-profile.md` (no `context.md` — el nombre fue actualizado)
- Español, Obsidian Markdown, regla de frescura de 15 días, sin links a grabaciones Clarity

---

## Archivos a crear

```
skills/webmometro-ux-site/
  SKILL.md
  references/ux-site-template.md

skills/webmometro-ux-page/
  SKILL.md
  references/ux-page-template.md
```

Luego copiar a `.claude/skills/` (gitignored, no versionado).

---

## Skill 1: `webmometro-ux-site`

### Frontmatter
```yaml
name: webmometro-ux-site
description: |
  Genera un informe UX del sitio completo orientado al equipo de diseño.
  Analiza comportamiento de usuarios agregado: frustración, engagement, flujos
  de navegación, diferencias por dispositivo y performance técnica, usando
  Google Analytics 4 y Microsoft Clarity.
  Usar cuando el usuario mencione: "informe ux del sitio", "reporte ux",
  "análisis de comportamiento del sitio", "ux site", "cómo se comportan los
  usuarios en el sitio", "qué páginas frustran", "experiencia de usuario del
  sitio", "diagnóstico ux", "ux report", "informe de usabilidad".
  NO usar para análisis de una página específica — derivar a webmometro-ux-page.
```

### Ruta de salida
`$SEO_REPORTS_PATH/{dominio}/ux/ux-site-{fecha}.md`

### Flujo de ejecución (7 pasos)

**Paso 0 — Contexto del negocio**
- Leer `$SEO_REPORTS_PATH/{dominio}/site-profile.md`
- Extraer: tipo de negocio, audiencias, objetivo principal del sitio
- Si no existe: continuar con análisis genérico + advertencia

**Paso 0.5 — Identificar MCP de Clarity**
- Listar MCPs que empiecen con `clarity-`
- Seleccionar por coincidencia semántica con el dominio
- Si ninguno → `clarity_mcp = null`, omitir pasos de Clarity sin error

**Paso 0.6 — Identificar GA4 property**
- `mcp__analytics-mcp__get_account_summaries` → listar propiedades
- Seleccionar la que coincide semánticamente con el dominio
- Si no hay ninguna → `ga4_property = null`, omitir pasos GA4

**Paso 1 — Audiencia y dispositivos (GA4)**
- `run_report`: dimensión `deviceCategory`, métricas: sessions, users, bounce_rate,
  averageSessionDuration, screenPageViews — últimos 30 días
- `run_report`: dimensión `userType` (new vs returning), métricas: sessions, bounceRate,
  averageSessionDuration
- Resultados: tabla comparativa mobile/tablet/desktop + tabla new vs returning

**Paso 2 — Engagement por página (GA4 + Clarity)**
- GA4: `run_report` dimensión `pagePath`, métricas: sessions, bounceRate,
  averageSessionDuration, screenPageViews — top 20 páginas por sesiones
- Clarity (si disponible): `query-analytics-dashboard` → scroll depth, quick backs
  y rage clicks para el sitio completo, últimos 30 días
- Cruzar: identificar páginas con mayor frustración (bounce alto + rage clicks)
  y páginas con mayor engagement (bounce bajo + scroll depth alto)

**Paso 3 — Señales de frustración (Clarity)**
- Si `clarity_mcp` disponible:
  - `query-analytics-dashboard` → rage clicks por página, últimos 30 días
  - `query-analytics-dashboard` → dead clicks por página, últimos 30 días
  - `query-analytics-dashboard` → quick backs por página, últimos 30 días
- Umbrales de alarma: quick backs >40%, rage clicks >5%, dead clicks >10%
- Ordenar páginas de mayor a menor señal de frustración

**Paso 4 — Flujos de navegación (GA4)**
- `run_report`: dimensión `sessionSource` + `sessionMedium`, métricas: sessions,
  bounceRate, averageSessionDuration — para identificar calidad por canal
- `run_report`: dimensión `pagePath` + `exitRate` si disponible — páginas de salida
- Objetivo: identificar dónde se pierden los usuarios

**Paso 5 — Performance técnica**
- `mcp__pagespeed__analyze_pagespeed` → mobile + desktop para la homepage
- Si Clarity disponible: `query-analytics-dashboard` → Core Web Vitals LCP/CLS del sitio
- Registrar: LCP, CLS, INP para mobile y desktop

**Paso 6 — Errores JavaScript (Clarity)**
- Si `clarity_mcp` disponible:
  - `query-analytics-dashboard` → JavaScript errors del sitio, últimos 30 días
- Listar errores con frecuencia

**Paso 7 — Generar informe**
- Calcular **UX Health Score** (ver Scoring Weights abajo)
- Generar informe Obsidian Markdown usando `references/ux-site-template.md`
- Guardar en `$SEO_REPORTS_PATH/{dominio}/ux/ux-site-{fecha}.md`

### UX Health Score (site)

| Categoría | Peso |
|---|---|
| Frustración (rage/dead clicks, quick backs) | 30% |
| Engagement (scroll depth, session duration, bounce) | 25% |
| Performance (CWV) | 20% |
| Diferencias mobile vs desktop | 15% |
| Errores JavaScript | 10% |

Escala: 🟢 85-100 / 🟡 70-84 / 🟠 50-69 / 🔴 0-49

---

## Skill 2: `webmometro-ux-page`

### Frontmatter
```yaml
name: webmometro-ux-page
description: |
  Genera un informe UX de una página específica orientado al equipo de diseño.
  Analiza comportamiento de usuarios en esa URL: frustración, engagement,
  scroll depth, performance y diferencias por dispositivo, usando
  Google Analytics 4 y Microsoft Clarity.
  Usar cuando el usuario mencione: "informe ux de esta página", "ux de esta url",
  "cómo se comportan los usuarios en esta página", "qué tan bien funciona esta
  página para los usuarios", "experiencia de usuario de esta página",
  "análisis de comportamiento de página", "ux page", "usabilidad de esta página",
  "diagnóstico ux de página", "qué tan frustrante es esta página".
  NO usar para análisis del sitio completo — derivar a webmometro-ux-site.
  NO usar para auditoría SEO — derivar a webmometro-seo-page-audit.
```

### Ruta de salida
`$SEO_REPORTS_PATH/{dominio}/ux/ux-page-{slug}-{fecha}.md`

### Flujo de ejecución (6 pasos)

**Paso 0 — Contexto del negocio**
- Leer `$SEO_REPORTS_PATH/{dominio}/site-profile.md`
- Extraer: tipo de negocio, objetivo del sitio, audiencias
- Si no existe: continuar + advertencia

**Paso 0.5 — Identificar MCP de Clarity**
- Igual que en ux-site

**Paso 0.6 — Identificar GA4 property**
- Igual que en ux-site

**Paso 1 — Comportamiento en Clarity (si disponible)**
- `query-analytics-dashboard` → quick backs, scroll depth, rage clicks, dead clicks
  para la URL específica, últimos 30 días
- Registrar con umbrales: quick backs >40% 🔴, scroll depth <50% 🔴,
  rage clicks >5% 🔴, dead clicks >10% 🟠

**Paso 2 — Engagement en GA4**
- `run_report`: filtro pagePath == {url}, dimensión `deviceCategory`,
  métricas: sessions, bounceRate, averageSessionDuration, screenPageViews — últimos 30 días
- `run_report`: filtro pagePath == {url}, dimensión `userType`,
  métricas: sessions, averageSessionDuration — últimos 30 días
- `run_report`: filtro pagePath == {url}, dimensión `sessionSource`,
  métricas: sessions, bounceRate — top 5 fuentes de tráfico

**Paso 3 — Performance (CWV)**
- `mcp__pagespeed__analyze_pagespeed` → mobile + desktop para la URL
- Registrar: LCP, CLS, INP, FCP, TTFB para ambos

**Paso 4 — Comparativa mobile vs desktop**
- Con los datos del Paso 2: comparar bounce rate, duración y sesiones por dispositivo
- Con los datos del Paso 3: comparar performance mobile vs desktop
- Si Clarity disponible: `query-analytics-dashboard` → rage clicks por dispositivo en esta URL
- Identificar si hay degradación significativa en mobile (diferencia >20% en bounce o >30% en duración)

**Paso 5 — Generar informe**
- Calcular **UX Page Score** (ver Scoring Weights abajo)
- Generar informe Obsidian Markdown usando `references/ux-page-template.md`
- Guardar en `$SEO_REPORTS_PATH/{dominio}/ux/ux-page-{slug}-{fecha}.md`

### UX Page Score

| Categoría | Peso |
|---|---|
| Frustración (rage/dead clicks, quick backs) | 35% |
| Engagement (scroll depth, duración, bounce) | 30% |
| Performance (CWV) | 20% |
| Paridad mobile/desktop | 15% |

Escala: 🟢 85-100 / 🟡 70-84 / 🟠 50-69 / 🔴 0-49

---

## Patrones compartidos (ambos skills)

**Control de frescura**: igual al page-audit — si existe reporte con <15 días, preguntar:
R (regenerar), C (cancelar), o número de sección a actualizar.

**Carga de site-profile**:
```
$SEO_REPORTS_PATH/{dominio}/site-profile.md
```
(No `context.md` — archivo renombrado en el skill webmometro-seo-site-profile)

**Política de errores MCP**: idéntica al page-audit — nunca omitir silenciosamente,
registrar bloque ⚠️ con qué dato falta y cómo obtenerlo.

**Identificación de Clarity**: misma lógica semántica que page-audit (paso 0.5).

**Formato**: Obsidian Markdown con callouts para hallazgos críticos, propiedades YAML
en frontmatter, tablas para datos, wikilinks para referencias cruzadas entre reportes.

---

## Secciones del informe final

### ux-site
1. Resumen ejecutivo + UX Health Score
2. Audiencia y dispositivos
3. Páginas con mayor frustración (tabla ordenada)
4. Engagement por página (scroll depth + duración)
5. Flujos de navegación y puntos de salida
6. Performance técnica (CWV)
7. Errores JavaScript
8. Plan de acción priorizado (🔴 Crítico / 🟠 Alto / 🟡 Backlog)

### ux-page
1. Ficha de la página (URL, título, tipo, contexto)
2. Resumen ejecutivo + UX Page Score
3. Comportamiento Clarity (rage/dead clicks, quick backs, scroll)
4. Engagement GA4 (sesiones, bounce, duración, por fuente)
5. Performance CWV (mobile + desktop)
6. Comparativa mobile vs desktop
7. Hallazgos y recomendaciones (por tipo: contenido / interacción / layout / performance)

---

## Verificación post-implementación

1. Ejecutar `/webmometro-ux-site observatoriodelcancer.cl` — debe identificar
   `clarity-observatorio-del-cancer` y GA4 property 469001777, generar informe en
   `reports/observatoriodelcancer.cl/ux/`
2. Ejecutar `/webmometro-ux-page [URL específica]` — debe generar informe en
   `reports/observatoriodelcancer.cl/ux/ux-page-{slug}-{fecha}.md`
3. Verificar que ambos informes usen Obsidian Markdown (callouts, frontmatter YAML)
4. Verificar control de frescura: ejecutar de nuevo en <15 días y confirmar que pregunta
   antes de regenerar
5. Verificar manejo de errores: si Clarity o GA4 fallan, el informe debe incluir bloque ⚠️
