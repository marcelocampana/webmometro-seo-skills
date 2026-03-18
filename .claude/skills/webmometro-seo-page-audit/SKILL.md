---
name: webmometro-seo-page-audit
description: >
  Auditoría SEO profunda de una página específica. Analiza on-page SEO, contenido,
  schema, performance y visibilidad en AI Search para una URL individual. Se apoya
  en el context.md del negocio para contextualizar hallazgos. Genera un reporte
  unificado con plan de acción priorizado por impacto en clicks.
  Usar cuando el usuario mencione: "auditar página", "auditar esta URL", "revisar página",
  "page audit", "auditoría de página", "analizar esta página", "revisar esta URL",
  "qué tan bien está esta página", "diagnóstico de página", "optimizar página",
  "mejorar esta página", "por qué no rankea esta página", "page seo", "on-page audit".
  NO usar para auditorías del sitio completo — derivar a webmometro-seo-context.
metadata:
  version: 1.0.0
  argument-hint: "[URL de la página]"
---

# webmometro-seo-page-audit — Auditoría de Página

Auditoría SEO profunda de una **página específica**. No del sitio completo.

## Regla fundamental: scope

**Este skill es para UNA página.** Si el usuario pide:
- Auditoría del sitio completo, diagnóstico general del dominio, health check del sitio → derivar:
  > "Para auditar el sitio completo, usa `/webmometro-seo-context [dominio]` — ese skill genera un diagnóstico integral con datos GSC, autoridad, canibalización y plan de acción para todo el dominio."
- Auditoría de múltiples páginas a la vez → preguntar cuál priorizar primero.

---

## Control de frescura del reporte

Antes de iniciar cualquier análisis, verificar si ya existe un reporte para esta página:

```
reports/{dominio}/audits/{fecha}-page-audit-{slug}.md
```

Si existe un reporte cuya fecha en el nombre de archivo tiene **menos de 15 días** desde hoy:

> "Ya existe un reporte de `{URL}` generado el {fecha} ({N} días). ¿Qué quieres hacer?
>
> **R** — Regenerar el reporte completo
> **C** — Cancelar
>
> O indica el número de la sección que quieres actualizar:
> 1. On-Page SEO (title, H1, meta, headings)
> 2. Contenido y E-E-A-T
> 3. Schema y datos estructurados
> 4. Performance y Core Web Vitals
> 5. Imágenes
> 6. Backlinks
> 7. Interlinks
> 8. Canibalización
> 9. Visibilidad en AI Search
> 10. Plan de acción"

Si el usuario responde con números, ejecutar **solo los pasos necesarios** para regenerar esas secciones (ver mapeo en la sección **Mapeo sección → pasos**). Actualizar solo esas secciones en el archivo existente, preservando el resto. Actualizar la fecha de "Última actualización" en el header.

Si el reporte tiene **15 días o más**, o no existe → ejecutar el flujo completo sin preguntar.

---

## Flujo de ejecución

Ejecutar en este orden.

### Paso 0 — Contexto del negocio

Verificar si existe `reports/{dominio}/context.md`:

- **Si existe**: leerlo. Extraer: tipo de negocio, audiencia objetivo SEO, pilares de contenido, tono de marca, keywords prioritarias. Este contexto informa qué es un "buen" resultado para esta página.
- **Si existe `reports/{dominio}/context/`**: leer también los archivos `.md` ahí (prioridad sobre `context.md`).
- **Si no existe**: continuar sin él, pero advertir al usuario:
  > "No encontré el contexto del negocio para `{dominio}`. El análisis será genérico. Para obtener hallazgos contextualizados al negocio, genera el perfil con `/webmometro-seo-context {dominio}`."

### Paso 1 — Datos GSC de la página

```
mcp__gsc__search_analytics  → dimensión "page", filtro: url == {URL}, últimos 90 días
mcp__gsc__enhanced_search_analytics → keywords que llevan tráfico a esta URL específica
```

Con los datos obtenidos, identificar:
- **Keyword principal**: la que aporta más impresiones a esta URL
- **Posición actual** de la keyword principal
- **CTR vs benchmark**: CTR esperado por posición (pos 1 ~28%, pos 3 ~10%, pos 5 ~6%, pos 10 ~2%). Gap = oportunidad de título/meta
- **Top 5 keywords** que traen tráfico a esta página (para el análisis de canibalización)

Si GSC no retorna datos para la URL, anotar "Sin datos GSC para esta URL" y continuar.

### Paso 2 — WebFetch de la página

Hacer fetch de la URL. Extraer y registrar con exactitud (texto literal, no interpretación):

**On-Page:**
- Title tag: texto completo + longitud en caracteres
- Meta description: texto completo + longitud
- H1: texto completo (¿presente? ¿cuántos?)
- Jerarquía de headings: H2 y H3 en orden, con texto
- Canonical tag: URL del canonical (¿coincide con la URL auditada?)
- Robots meta: index/noindex, follow/nofollow

**Contenido:**
- Word count estimado (contar palabras visibles aproximadamente)
- Fecha de publicación / última actualización (si está visible en la página)
- Señales E-E-A-T: ¿hay autoría mencionada? ¿credenciales? ¿fecha? ¿fuentes citadas?
- Presencia de CTA: ¿hay llamada a la acción? ¿cuál?

**Schema JSON-LD:**
- Extraer todos los bloques `<script type="application/ld+json">` que existan
- Para cada bloque: tipo (`@type`) y campos presentes

**Imágenes:**
- Cantidad total de imágenes
- Cuántas tienen alt text ausente o vacío
- Formatos detectados (jpg, png, webp, etc.)

### Paso 3 — OnPage técnico de la URL

```
mcp__dataforseo__onpage_task_post  → crawl de la URL específica (no del sitio)
mcp__dataforseo__onpage_tasks_ready → polling hasta estado ready (máx 3 intentos, ~5s entre intentos)
mcp__dataforseo__onpage_pages      → resultados técnicos de la URL
```

Si no está lista tras 3 intentos: continuar con los datos del WebFetch, anotar "OnPage pendiente" y al final hacer un último intento. Si sigue sin estar lista, registrar el `task_id` en el reporte.

Extraer de OnPage: onpage_score, issues detectados, tiempo de carga, tamaño de página, profundidad de crawl.

### Paso 4 — Performance

```
mcp__pagespeed__analyze_pagespeed  → mobile + desktop para la URL
```

Registrar para mobile y desktop:
- Performance score
- LCP (Largest Contentful Paint)
- CLS (Cumulative Layout Shift)
- INP / FID (Interaction to Next Paint)
- FCP (First Contentful Paint)
- TTFB (Time to First Byte)

Identificar el "top opportunity" de PageSpeed si lo hay.

### Paso 5 — SERP de la keyword principal

```
mcp__dataforseo__serp_google_organic_live → keyword principal de la página (location_code: 2152, language_code: es, depth: 10)
```

Verificar:
- Posición orgánica real del dominio para esa keyword
- SERP features presentes: AI Overview, Featured Snippet, PAA, Local Pack, Video, Shopping
- ¿Aparece el dominio en AI Overview o en PAA?
- Top 3 competidores orgánicos y qué tienen que el dominio no tiene (title, schema, contenido visible)

Si la keyword principal es de navegación de marca (ej: "clínica dra. zaror"), usar la segunda keyword más relevante no-brand.

### Paso 6 — Backlinks hacia la página

```
mcp__dataforseo__backlinks_backlinks  → target: URL específica (no dominio). Extraer: dominios referentes, URL de origen, anchor text, spam score de cada backlink
mcp__dataforseo__backlinks_anchors    → target: URL específica. Distribución de anchor text hacia esta página
```

Con los datos obtenidos, analizar:
- Total de dominios únicos que enlazan a esta URL y total de backlinks
- Top 5 backlinks ordenados por autoridad del dominio referente (dominio + URL de origen + anchor text + spam score)
- Distribución de anchor text: ¿cuántos usan la keyword objetivo vs variantes vs marca vs genéricos vs URL desnuda?
- ¿El anchor text dominante refuerza o contradice la keyword que se quiere rankear?

Si no hay backlinks hacia la URL específica, anotarlo y continuar.

### Paso 7 — Interlinks (links internos)

Los datos de OnPage (Paso 3) ya incluyen `inbound_links_count` (links internos entrantes) e `internal_links_count` (links salientes). Complementar con los datos de la página ya obtenidos en el WebFetch (Paso 2) para extraer los links salientes y sus destinos.

Analizar:
- **Links entrantes internos**: cuántas páginas del sitio enlazan a esta URL (dato de OnPage). Si hay detalle de qué páginas y con qué anchors, incluirlo.
- **Links salientes internos**: desde esta página, ¿a cuántas URLs del mismo dominio apunta? ¿Son temáticamente relevantes para la keyword objetivo?
- **Oportunidades**: cruzar las top 10 páginas por clicks del Paso 1 (GSC) con la URL auditada — ¿hay páginas con alto tráfico que temáticamente deberían enlazar aquí y no lo hacen? Proponer anchor text específico para cada oportunidad.

### Paso 8 — Canibalización

Con las top 5 keywords de GSC (Paso 1):

```
mcp__dataforseo__labs_google_keywords_for_site → filtrar por keyword, verificar qué otras URLs del dominio rankean para las mismas keywords
```

Identificar:
- ¿Hay otras URLs del mismo dominio rankeando para las mismas keywords que esta página?
- Si sí: ¿es canibalización real (dos URLs compiten, ninguna llega a top 3) o variantes normales?
- Acción recomendada: consolidar, canonical, redirect, o ninguna

Si no hay datos suficientes de GSC, omitir este paso y anotarlo.

### Paso 9 — Score y reporte

Calcular el **Page SEO Score** con los pesos definidos en **Scoring Weights**.

Al generar el reporte:

- **Título**: usar el último segmento de la URL como nombre. Ej: `/tratamientos/esteticos/hifu-12d` → `# Auditoría de Página — hifu-12d`. Para la homepage (`/`) usar `home`.
- **Score con rangos**: en la fila TOTAL de la tabla de scoring, incluir el estado directamente junto al puntaje (ej: `**43.40/100 — 🔴 Crítico**`). Luego mostrar la tabla de rangos de referencia:
  - 🟢 Excelente: 85–100
  - 🟡 Bueno: 70–84
  - 🟠 Necesita mejoras: 50–69
  - 🔴 Crítico: 0–49
- **Plan de acción**: usar siempre los íconos en los títulos de cada nivel — 🔴 Crítico / 🟠 Alto impacto / 🟡 Backlog.
- **Keywords GSC**: colocar esta sección inmediatamente después del resumen ejecutivo, antes del plan de acción.

Generar el reporte usando el template en `references/page-audit-template.md`.

Guardar en: `reports/{dominio}/audits/{fecha}-page-audit-{slug}.md`

Donde `{slug}` es el último segmento del path de la URL (ej: `/tratamientos/esteticos/hifu-12d` → `hifu-12d`, `/` → `home`).

---

## Mapeo sección → pasos

Para regeneraciones parciales, ejecutar solo los pasos necesarios:

| Sección | Pasos a ejecutar |
|---|---|
| 1. On-Page SEO | Paso 2 (WebFetch) + Paso 3 (OnPage) |
| 2. Contenido y E-E-A-T | Paso 2 (WebFetch) |
| 3. Schema | Paso 2 (WebFetch) |
| 4. Performance | Paso 4 (PageSpeed) |
| 5. Imágenes | Paso 2 (WebFetch) |
| 6. Backlinks | Paso 6 (backlinks_backlinks + backlinks_anchors) |
| 7. Interlinks | Paso 3 (OnPage — datos ya obtenidos) + Paso 2 (WebFetch — links salientes) |
| 8. Canibalización | Paso 1 (GSC) + Paso 8 |
| 9. Visibilidad AI Search | Paso 5 (SERP) |
| Keywords y GSC (resumen ejecutivo) | Paso 1 (GSC) |
| 10. Plan de acción | Requiere datos actuales — reejecutar pasos relevantes |

---

## Scoring Weights

| Categoría | Peso |
|---|---|
| On-Page SEO | 25% |
| Contenido y E-E-A-T | 20% |
| Technical SEO | 15% |
| Schema / Datos estructurados | 10% |
| Backlinks | 10% |
| Performance (CWV) | 10% |
| Visibilidad en AI Search | 5% |
| Interlinks | 5% |

*(Imágenes se analiza como sección cualitativa pero no contribuye al score numérico)*

---

## MCP Tools

| Tool | Paso | Cuándo usar |
|---|---|---|
| `mcp__gsc__search_analytics` | 1 | Siempre |
| `mcp__gsc__enhanced_search_analytics` | 1 | Siempre |
| `mcp__dataforseo__onpage_task_post` | 3 | Siempre |
| `mcp__dataforseo__onpage_tasks_ready` | 3 | Después de onpage_task_post |
| `mcp__dataforseo__onpage_pages` | 3 | Después de onpage_tasks_ready |
| `mcp__pagespeed__analyze_pagespeed` | 4 | Siempre |
| `mcp__dataforseo__serp_google_organic_live` | 5 | Siempre |
| `mcp__dataforseo__backlinks_backlinks` | 6 | Siempre — target: URL específica |
| `mcp__dataforseo__backlinks_anchors` | 6 | Siempre — target: URL específica |
| `mcp__dataforseo__labs_google_keywords_for_site` | 8 | Si hay keywords GSC |

---

## Priority Definitions

- **Critical**: Bloquea indexación, canonical incorrecto, noindex activo, o impacto estimado muy alto. Fix inmediato.
- **High**: Impacto estimado >50 clicks/mes con esfuerzo bajo-medio. Esta semana.
- **Medium**: Impacto 10–50 clicks/mes o mejora estructural con beneficio a largo plazo. Este mes.
- **Low**: Impacto <10 clicks/mes o mejora de calidad sin impacto directo en tráfico. Backlog.

---

## Template de reporte

Ver [references/page-audit-template.md](references/page-audit-template.md)
