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

## Configuración de ruta de reportes

Al iniciar, resolver la ruta base de reportes:

- Si `$SEO_REPORTS_PATH` está definida → usar ese valor como `REPORTS_DIR`
- Si no está definida → usar `{cwd}/reports` como `REPORTS_DIR` y advertir al usuario:
  > "No encontré `SEO_REPORTS_PATH`. Guardando reportes en `{cwd}/reports`. Para usar otra ubicación, define `SEO_REPORTS_PATH` en `.claude/settings.json`."

Si `REPORTS_DIR` no existe, crearlo con `mkdir -p` antes de continuar.

Todas las referencias a `$SEO_REPORTS_PATH` en este skill se resuelven como `REPORTS_DIR`.

---

## Estilo de escritura del informe

Los informes son leídos por equipos de marketing, comunicaciones y gestión de sitios web que entienden el negocio pero no necesariamente la jerga técnica de analítica, SEO o UX. Al redactar cualquier texto — callouts, párrafos de análisis, interpretaciones, recomendaciones — aplicar estas reglas:

1. **Aclarar términos técnicos cuando el contexto lo requiere.** El criterio no es "solo la primera vez en el informe", sino evaluar si el lector que llega directamente a esa sección entendería el término sin contexto previo. Si un término es central para comprender el hallazgo que se está explicando, aclararlo aunque ya haya aparecido antes. Si en esa sección ya fue explicado, no repetirlo.

2. **Siglas técnicas**: expandir en español cada vez que aparezcan en una sección nueva o en un contexto donde sean el dato principal del análisis:
   - LCP → "LCP (tiempo en cargar el elemento visual principal)"
   - CLS → "CLS (estabilidad visual durante la carga)"
   - INP → "INP (velocidad de respuesta a interacciones)"
   - FCP → "FCP (aparición del primer contenido visible)"
   - TTFB → "TTFB (tiempo de respuesta inicial del servidor)"

3. **Términos en inglés de comportamiento**: integrar la aclaración de forma natural cuando el término es clave para entender el análisis:
   - Bounce rate → "tasa de rebote (bounce rate)"
   - Dead clicks → "clics sin respuesta (dead clicks) — clics sobre elementos que parecen interactivos pero no hacen nada"
   - Rage clicks → "clics de frustración (rage clicks) — clics repetidos y rápidos cuando un elemento no responde"
   - Quick backs → "salidas inmediatas (quick backs) — el usuario entra a la página y vuelve atrás en pocos segundos"
   - Scroll depth → "profundidad de scroll — qué porcentaje de la página desplazan hacia abajo los usuarios"
   - Engagement → usar "nivel de interacción" o "interacción y engagement" en encabezados; en texto corrido integrar la aclaración cuando sea el concepto central del párrafo

4. **No saturar**: la aclaración debe sentirse natural, no mecánica. Si en un párrafo breve el mismo término aparece dos veces, aclarar solo una. El objetivo es que cualquier lector pueda entender el hallazgo sin tener que buscar definiciones externamente.

5. **Encabezados y títulos de tabla**: preferir el término en español directamente cuando el reemplazo es limpio. Los paréntesis son para texto corrido donde conviene conservar el término técnico como referencia.

---

## Control de frescura del reporte

Antes de iniciar cualquier análisis, verificar si ya existe un reporte para esta página:

```
$SEO_REPORTS_PATH/{dominio}/audits/{fecha}-page-audit-{slug}.md
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

Verificar si existe `$SEO_REPORTS_PATH/{dominio}/context.md`:

- **Si existe**: leerlo. Extraer: tipo de negocio, audiencia objetivo SEO, pilares de contenido, tono de marca, keywords prioritarias. Este contexto informa qué es un "buen" resultado para esta página.
- **Si existe `$SEO_REPORTS_PATH/{dominio}/context/`**: leer también los archivos `.md` ahí (prioridad sobre `context.md`).
- **Si no existe**: continuar sin él, pero advertir al usuario:
  > "No encontré el contexto del negocio para `{dominio}`. El análisis será genérico. Para obtener hallazgos contextualizados al negocio, genera el perfil con `/webmometro-seo-context {dominio}`."

### Paso 0.5 — Identificar MCP de Microsoft Clarity

Antes de ejecutar el flujo principal, verificar si existe un MCP de Clarity para este dominio:

1. Listar todos los MCPs disponibles que empiecen con `clarity-`
2. Elegir el que semánticamente más se parezca al dominio o nombre del negocio (comparación visual/semántica, no string matching exacto — ej: `observatoriodelcancer.cl` → `clarity-observatorio-del-cancer`)
3. Si hay ambigüedad entre dos candidatos, preguntar al usuario cuál corresponde
4. Si ninguno corresponde: `clarity_mcp = null` — omitir todos los pasos de Clarity sin error

Guardar el resultado como `clarity_mcp` para usarlo en el Paso 2.5.

---

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

### Paso 2.5 — Comportamiento de usuario (Clarity)

**Solo si `clarity_mcp` fue identificado en el Paso 0.5.**

Ejecutar dos queries al MCP identificado:

```
{clarity_mcp}__query-analytics-dashboard →
  "Quick backs, scroll depth, rage clicks, dead clicks para {URL}, últimos 30 días"

{clarity_mcp}__list-session-recordings →
  filtrar por URL auditada, ordenar por SessionDuration_DESC, count: 5
```

Registrar:
- **Quick backs (%)**: porcentaje de sesiones que volvieron al SERP rápidamente. >40% = señal de intención no satisfecha
- **Scroll depth promedio**: si <50% del contenido es leído → problema de estructura o relevancia
- **Rage clicks**: si hay rage clicks, identificar en qué zona de la página ocurren
- **Dead clicks**: elementos no interactivos que los usuarios intentan clickear (confusión de UX)
- **Duración promedio de sesión** (desde list-session-recordings): proxy de engagement con el contenido

Estos datos se usan en las secciones "Contenido y E-E-A-T" y "Plan de acción" del reporte.

Si Clarity no retorna datos para la URL específica (sin suficiente tráfico o sin datos del período), anotar "Sin datos Clarity para esta URL" y continuar.

---

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

Guardar en: `$SEO_REPORTS_PATH/{dominio}/audits/{fecha}-page-audit-{slug}.md`

Donde `{slug}` es el último segmento del path de la URL (ej: `/tratamientos/esteticos/hifu-12d` → `hifu-12d`, `/` → `home`).

---

## Mapeo sección → pasos

Para regeneraciones parciales, ejecutar solo los pasos necesarios:

| Sección | Pasos a ejecutar |
|---|---|
| 1. On-Page SEO | Paso 2 (WebFetch) + Paso 3 (OnPage) |
| 2. Contenido y E-E-A-T | Paso 2 (WebFetch) + Paso 2.5 (Clarity) |
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
| `{clarity_mcp}__query-analytics-dashboard` | 2.5 | Si clarity_mcp fue identificado |
| `{clarity_mcp}__list-session-recordings` | 2.5 | Si clarity_mcp fue identificado |
| `mcp__dataforseo__onpage_task_post` | 3 | Siempre |
| `mcp__dataforseo__onpage_tasks_ready` | 3 | Después de onpage_task_post |
| `mcp__dataforseo__onpage_pages` | 3 | Después de onpage_tasks_ready |
| `mcp__pagespeed__analyze_pagespeed` | 4 | Siempre |
| `mcp__dataforseo__serp_google_organic_live` | 5 | Siempre |
| `mcp__dataforseo__backlinks_backlinks` | 6 | Siempre — target: URL específica |
| `mcp__dataforseo__backlinks_anchors` | 6 | Siempre — target: URL específica |
| `mcp__dataforseo__labs_google_keywords_for_site` | 8 | Si hay keywords GSC |

---

## Política de errores de MCP

Si un MCP falla, no está disponible, o no retorna datos para la URL analizada, **nunca omitir silenciosamente**. En todos los casos:

1. Continuar con los demás pasos sin interrumpir el flujo
2. En la sección correspondiente del reporte, registrar:

```
> ⚠️ **Datos no disponibles** — {nombre del MCP} no respondió o no está instalado.
> Sin estos datos, {descripción del valor que aportaría}.
> Para obtener esta información, instala o verifica la configuración de `{nombre-mcp}`.
```

Referencia por MCP y sección afectada:

| MCP | Sección afectada | Valor que aportaría si estuviera activo |
|---|---|---|
| `gsc` | Keywords GSC, Canibalización | Clicks, impresiones, CTR real, keywords que traen tráfico a esta URL |
| `dataforseo` (OnPage) | Technical SEO | Score técnico, issues de crawl, tiempo de carga, profundidad |
| `dataforseo` (SERP) | Visibilidad en AI Search | Posición real, SERP features, comparación con competidores |
| `dataforseo` (backlinks) | Backlinks | Dominios referentes, anchor text, spam score |
| `dataforseo` (labs) | Canibalización | Otras URLs del dominio rankeando para las mismas keywords |
| `pagespeed` | Performance y CWV | LCP, CLS, INP, FCP, TTFB para mobile y desktop |
| `clarity-{proyecto}` | Comportamiento de usuario (Contenido/E-E-A-T) | Quick backs, scroll depth, rage clicks, duración de sesión orgánica |

Si una categoría del score no tiene datos por fallo de MCP, excluirla del cálculo y anotarlo en la tabla de scoring con `— (sin datos)`.

---

## Priority Definitions

- **Critical**: Bloquea indexación, canonical incorrecto, noindex activo, o impacto estimado muy alto. Fix inmediato.
- **High**: Impacto estimado >50 clicks/mes con esfuerzo bajo-medio. Esta semana.
- **Medium**: Impacto 10–50 clicks/mes o mejora estructural con beneficio a largo plazo. Este mes.
- **Low**: Impacto <10 clicks/mes o mejora de calidad sin impacto directo en tráfico. Backlog.

---

## Template de reporte

Ver [references/page-audit-template.md](references/page-audit-template.md)
