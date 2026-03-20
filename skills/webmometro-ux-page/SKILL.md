---
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
  "diagnóstico ux de página", "qué tan frustrante es esta página",
  "rage clicks de esta página", "scroll de esta página", "comportamiento en esta url",
  "quick backs de esta página", "análisis de esta url", "cómo navegan en esta página".
  NO usar para análisis del sitio completo — derivar a webmometro-ux-site.
  NO usar para auditoría SEO — derivar a webmometro-seo-page-audit.
metadata:
  version: 1.0.0
  argument-hint: "[URL de la página]"
---

# webmometro-ux-page — Informe UX de Página

Genera un informe de experiencia de usuario para **una página específica**, orientado al equipo de diseño. Analiza en profundidad cómo los usuarios interactúan con esa URL usando Clarity (señales de comportamiento) y GA4 (engagement y fuentes de tráfico).

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

## Regla fundamental: scope

**Este skill es para UNA página.** Si el usuario pide:
- Análisis del sitio completo → derivar:
  > "Para analizar la UX del sitio completo, usa `/webmometro-ux-site [dominio]`."
- Auditoría SEO de la página (on-page, schema, backlinks, rankings) → derivar:
  > "Para auditar la página desde el punto de vista SEO, usa `/webmometro-seo-page-audit [URL]`."
- Múltiples páginas a la vez → preguntar cuál priorizar primero.

---

## Configuración de ruta de reportes

Al iniciar, resolver la ruta base de reportes:

- Si `$SEO_REPORTS_PATH` está definida → usar ese valor como `REPORTS_DIR`
- Si no está definida → usar `{cwd}/reports` como `REPORTS_DIR` y advertir al usuario:
  > "No encontré `SEO_REPORTS_PATH`. Guardando reportes en `{cwd}/reports`. Para usar otra ubicación, define `SEO_REPORTS_PATH` en `.claude/settings.json`."

Si `REPORTS_DIR` no existe, crearlo con `mkdir -p`.

---

## Control de frescura del reporte

Antes de iniciar, verificar si ya existe un reporte para esta página:

```
$SEO_REPORTS_PATH/{dominio}/ux/ux-page-{slug}-*.md
```

Si existe un reporte con **menos de 15 días** desde hoy:

> "Ya existe un informe UX de `{URL}` generado el {fecha} ({N} días). ¿Qué quieres hacer?
>
> **R** — Regenerar el informe completo
> **C** — Cancelar
>
> O indica el número de la sección que quieres actualizar:
> 0. Inspección visual (menú, CTAs, elementos interactivos)
> 1. Comportamiento Clarity (rage/dead clicks, quick backs, scroll)
> 2. Engagement GA4 (sesiones, bounce, duración)
> 3. Performance CWV
> 4. Navegación desde esta página (clics del menú)
> 5. Comparativa mobile vs desktop
> 6. Hallazgos y recomendaciones"

Si el usuario responde con números, ejecutar solo los pasos necesarios y actualizar esas secciones. Si el reporte tiene **15 días o más**, o no existe → ejecutar el flujo completo.

---

## Flujo de ejecución

### Paso 0 — Contexto del negocio

Verificar si existe `$SEO_REPORTS_PATH/{dominio}/site-profile.md`:

- **Si existe**: leerlo. Extraer: tipo de negocio, objetivo principal del sitio, audiencias. Además, buscar la tabla de top páginas más visitadas (habitualmente bajo "Top páginas orgánicas" o similar) y verificar si la URL analizada está entre las **5 primeras**. Si está → `nav_analysis = true`. Si no está → `nav_analysis = false`.
- **Si no existe**: continuar sin él, `nav_analysis = false`, y advertir:
  > "No encontré el perfil del negocio para `{dominio}`. El análisis será genérico. Para obtener hallazgos contextualizados, genera el perfil con `/webmometro-seo-site-profile {dominio}`."

Derivar el `{slug}` de la URL: usar el último segmento del path (ej: `/blog/cancer-de-mama` → `cancer-de-mama`, `/` → `home`).

### Paso 0.5 — Identificar MCP de Microsoft Clarity

1. Listar todos los MCPs disponibles que empiecen con `clarity-`
2. Elegir el que semánticamente más se parezca al dominio o nombre del negocio (comparación visual/semántica — ej: `observatoriodelcancer.cl` → `clarity-observatorio-del-cancer`)
3. Si hay ambigüedad entre dos candidatos, preguntar al usuario cuál corresponde
4. Si ninguno corresponde: `clarity_mcp = null` — omitir todos los pasos de Clarity sin error

### Paso 0.6 — Identificar propiedad GA4

```
mcp__analytics-mcp__get_account_summaries → listar todas las propiedades GA4 disponibles
```

Seleccionar la propiedad que semánticamente más se parezca al dominio. Guardar como `ga4_property_id`.

Si el tool falla con error de reautenticación (`Reauthentication is needed` o `gcloud auth`):
- `ga4_property = null` — omitir todos los pasos GA4
- Mostrar en pantalla (no solo en el informe) el bloque de resolución completo:

```
⚠️  GA4 requiere re-autenticación

Ejecuta este comando en una terminal y sigue las instrucciones en pantalla:

gcloud auth application-default login \
  --scopes https://www.googleapis.com/auth/analytics.readonly,https://www.googleapis.com/auth/cloud-platform \
  --client-id-file="/Users/marcelocampana/Projects/mcps/credentials/client_secret_728451328493-7iui8q0bbpicgb3fdukfe84goa5emsvd.apps.googleusercontent.com.json"

El comando abrirá el navegador para que autorices el acceso con tu cuenta de Google.
Una vez completado, las credenciales se guardan automáticamente en:
/Users/marcelocampana/.config/gcloud/application_default_credentials.json

Cuando termines, responde "listo" para regenerar la sección de GA4.
```

Esperar respuesta del usuario. Si responde "listo" o similar → reintentar `mcp__analytics-mcp__get_account_summaries` y continuar con los pasos GA4. Si no responde o cancela → registrar en el informe:

```
> ⚠️ **Datos de GA4 no disponibles** — Token de autenticación expirado.
> Para obtener estos datos, ejecuta el comando de re-autenticación y regenera la sección 2.
```

Si no hay ninguna propiedad disponible por otro motivo: `ga4_property = null` — omitir pasos GA4, registrar bloque ⚠️.

---

### Paso 0.7 — Inspección visual con Chrome DevTools

Captura datos verificados directamente del sitio — estructura real del menú, textos de CTAs y elementos interactivos — que Clarity y GA4 no pueden proveer con precisión (Clarity enmascara textos; solo registra lo que el usuario clicó, no lo que existe).

Si `chrome-devtools` no está disponible o falla en cualquier sub-paso → continuar sin este paso. Registrar en "Notas de datos" del informe y continuar con el Paso 1.

**1. Navegar a la URL:**
```
mcp__chrome-devtools__navigate_page → URL de la página
```

**2. Screenshot desktop** (viewport 1280px):
```
mcp__chrome-devtools__take_screenshot
```

**3. Screenshot mobile** (viewport 375px):
```
mcp__chrome-devtools__emulate → device: "iPhone 12"
mcp__chrome-devtools__take_screenshot
```

**4. Extraer menú desktop** (volver a desktop primero):
```
mcp__chrome-devtools__emulate → viewport desktop (1280px)
mcp__chrome-devtools__evaluate_script →
  document.querySelectorAll('nav a, header nav a, header ul li a')
  retornar array de {texto: el.innerText.trim(), href: el.getAttribute('href')}
  filtrar vacíos
```

**5. Capturar menú mobile expandido:**
```
mcp__chrome-devtools__emulate → device: "iPhone 12"
mcp__chrome-devtools__click → selector del botón hamburguesa (buscar: button[aria-label*="menu"], .hamburger, .menu-toggle, button con ícono en header)
mcp__chrome-devtools__evaluate_script → mismo script que paso 4 pero sobre el menú expandido
```

**6. Identificar CTAs principales** (volver a desktop):
```
mcp__chrome-devtools__emulate → viewport desktop
mcp__chrome-devtools__evaluate_script →
  document.querySelectorAll('main a, main button, .hero a, .hero button, section a[class*="btn"], section button')
  retornar array de {texto: el.innerText.trim(), zona: identificar si está en hero/sección/footer}
  filtrar vacíos y links de navegación del menú
```

**7. Identificar elementos interactivos vs decorativos:**
```
mcp__chrome-devtools__evaluate_script →
  Listar elementos en main/section que tienen cursor: pointer (getComputedStyle) pero NO tienen href ni onclick
  Estos son candidatos a dead clicks — elementos que parecen clicables pero no hacen nada
```

**Guardar internamente:**
- `menu_desktop[]` — {texto, href} por ítem
- `menu_mobile[]` — {texto, href} por ítem (menú expandido)
- `ctas[]` — {texto, zona} de botones y links principales
- `decorative_interactive[]` — elementos con cursor:pointer sin acción
- `screenshot_desktop`, `screenshot_mobile` — referencias a las capturas

**Comparación obligatoria:** Si `menu_desktop` y `menu_mobile` difieren en textos o cantidad de ítems → documentar diferencias explícitas. Si son idénticos → confirmarlo en una línea.

---

### Paso 1 — Comportamiento en Clarity

**Solo si `clarity_mcp` fue identificado.**

```
{clarity_mcp}__query-analytics-dashboard →
  "Quick backs, scroll depth, rage clicks y dead clicks para {URL}, últimos 30 días"
```

Registrar con umbrales de interpretación:

| Métrica | Valor obtenido | Umbral | Estado |
|---|---|---|---|
| Quick backs | {%} | >40% = mismatch de contenido | {emoji} |
| Scroll depth | {%} | <50% = estructura o contenido problemático | {emoji} |
| Rage clicks | {%} | >5% = frustración activa | {emoji} |
| Dead clicks | {%} | >10% = confusión de UX | {emoji} |

Si Clarity no retorna datos para esta URL (sin tráfico suficiente o sin datos en el período), anotar y continuar.

### Paso 2 — Engagement en GA4

**Solo si `ga4_property` fue identificado.**

**Nota metodológica importante**: GA4 no permite filtrar dimensiones de sesión (`deviceCategory`, `newVsReturning`, `sessionDefaultChannelGroup`) por `pagePath` en un mismo reporte — son dimensiones de ámbito de sesión, no de página. Los reportes de dispositivo y canal se ejecutan **sin filtro de URL** y corresponden al sitio completo. En el informe, documentar que los datos reflejan el sitio completo como contexto de la audiencia que visita la página.

La única excepción es `pagePath` como dimensión propia: se puede usar para filtrar métricas de página (`screenPageViews`, `exits`) en reportes de ámbito de página.

Ejecutar en paralelo (sin dimension_filter):

```
mcp__analytics-mcp__run_report →
  property_id: ga4_property_id (número entero, sin comillas)
  dimensions: ["deviceCategory"]
  metrics: ["sessions", "bounceRate", "averageSessionDuration", "screenPageViews"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]

mcp__analytics-mcp__run_report →
  property_id: ga4_property_id
  dimensions: ["newVsReturning"]
  metrics: ["sessions", "averageSessionDuration"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]
```

Luego, en llamada separada:

```
mcp__analytics-mcp__run_report →
  property_id: ga4_property_id
  dimensions: ["sessionDefaultChannelGroup"]
  metrics: ["sessions", "bounceRate"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]
  order_bys: [{"metric": {"metric_name": "sessions"}, "desc": true}]
  limit: 5
```

**Importante**: Máximo 2-3 llamadas GA4 en paralelo. Llamadas adicionales en tanda separada.

Registrar:
- Tabla de dispositivos (sesiones, bounce, duración) — nota: datos del sitio completo
- Tabla new vs returning — nota: datos del sitio completo
- Top 5 canales con bounce rate

### Paso 3 — Performance (CWV)

```
mcp__pagespeed__analyze_pagespeed → mobile para la URL
mcp__pagespeed__analyze_pagespeed → desktop para la URL
```

El tool retorna: score global (0-100) y `topImprovements`. Los valores de CWV de campo pueden venir como "N/A" si el sitio no tiene datos suficientes en Chrome UX Report.

Registrar siempre:
- Score PageSpeed mobile y desktop
- Top 3 oportunidades con su impacto estimado

Si los valores de CWV de campo están disponibles (no "N/A"), registrar también:
- LCP — umbral: ≤2.5s ✅ / 2.5-4s ⚠️ / >4s 🔴
- CLS — umbral: ≤0.1 ✅ / 0.1-0.25 ⚠️ / >0.25 🔴
- INP — umbral: ≤200ms ✅ / 200-500ms ⚠️ / >500ms 🔴
- FCP — umbral: ≤1.8s ✅
- TTFB — umbral: ≤800ms ✅

Si son "N/A", anotar en el informe y usar como referencia los valores de Clarity si están disponibles.

### Paso 3.5 — Navegación desde esta página (solo si `nav_analysis = true`)

**Solo ejecutar si la página analizada está en el TOP 5 de páginas más visitadas según el site-profile.**

Esta página actúa como distribuidor de tráfico. El objetivo es entender si los enlaces de navegación (menú principal, CTAs del hero, secciones de acceso rápido) están captando el interés esperado y si ese interés se convierte en navegación real.

**Clarity** — si `clarity_mcp` disponible, ejecutar en paralelo:

```
{clarity_mcp}__query-analytics-dashboard →
  "Top URLs clicadas desde {URL} en desktop, últimos 30 días"

{clarity_mcp}__query-analytics-dashboard →
  "Top URLs clicadas desde {URL} en mobile, últimos 30 días"
```

**GA4** — si `ga4_property` disponible, en tanda separada:

```
mcp__analytics-mcp__run_report →
  property_id: ga4_property_id
  dimensions: ["pagePath"]
  metrics: ["sessions", "bounceRate", "averageSessionDuration"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]
  order_bys: [{"metric": {"metric_name": "sessions"}, "desc": true}]
  limit: 10
```

Cruzar: para cada URL que aparece en los clics de Clarity, buscar su engagement en GA4.

Registrar en tabla:

| Destino | Clics desde {slug} (desktop) | Clics desde {slug} (mobile) | Sesiones GA4 | Bounce GA4 | Diagnóstico |
|---|---|---|---|---|---|
| {url} | {n} | {n} | {n} | {%} | {emoji + nota} |

Diagnóstico por fila:
- Clics altos + bounce bajo → ✅ El enlace capta interés real y la página destino lo sostiene
- Clics altos + bounce alto → 🟠 El enlace genera interés pero la página destino defrauda
- Clics bajos en mobile vs desktop → 🔴 El enlace no es visible o accesible en mobile
- URL sin clics desde esta página pero con tráfico en GA4 → 🟡 Llegan por otra vía, no desde la navegación de esta página

> [!note] Nota metodológica
> Los clics de Clarity corresponden a interacciones registradas en los heatmaps de la página. GA4 muestra el engagement total de cada página destino, no solo las sesiones provenientes de esta página — se usa como indicador de si la página destino retiene a los usuarios que llegan, independientemente del origen.

### Paso 4 — Comparativa mobile vs desktop

Con los datos del Paso 2 y Paso 3, comparar:

- **Comportamiento**: bounce rate, duración promedio y sesiones por dispositivo
- **Performance**: LCP y CLS mobile vs desktop

Si `clarity_mcp` disponible:
```
{clarity_mcp}__query-analytics-dashboard →
  "Rage clicks por tipo de dispositivo en {URL}, últimos 30 días"
```

Identificar degradación significativa:
- Bounce mobile vs desktop: diferencia >20 puntos porcentuales → 🔴 Problema de experiencia mobile
- Duración mobile vs desktop: diferencia >30% → 🔴 Contenido o layout no adaptado a mobile
- LCP mobile >4s con desktop <2.5s → 🔴 Performance mobile crítica

### Paso 5 — Generar informe

Calcular el **UX Page Score**:

| Categoría | Peso | Cómo puntuar |
|---|---|---|
| Frustración (rage/dead clicks, quick backs) | 35% | Sin señales = 100; cada señal 🔴 resta 20pts, 🟠 resta 10pts |
| Engagement (scroll depth, duración, bounce) | 30% | Basado en umbrales de cada métrica |
| Performance CWV | 20% | Promedio ponderado mobile (60%) + desktop (40%) |
| Paridad mobile/desktop | 15% | Sin degradación = 100; degradación 🔴 = 40pts, 🟠 = 70pts |

Si una categoría no tiene datos por fallo de MCP → excluirla del cálculo y anotarla con `— (sin datos)`.

Escala: 🟢 Excelente 85-100 / 🟡 Bueno 70-84 / 🟠 Necesita mejoras 50-69 / 🔴 Crítico 0-49

Generar el informe usando el template en `references/ux-page-template.md`.

Guardar en: `$SEO_REPORTS_PATH/{dominio}/ux/ux-page-{slug}-{fecha}.md`

---

## Mapeo sección → pasos (para regeneraciones parciales)

| Sección | Pasos a ejecutar |
|---|---|
| 0. Inspección visual | Paso 0.7 |
| 1. Comportamiento Clarity | Paso 1 |
| 2. Engagement GA4 | Paso 2 |
| 3. Performance CWV | Paso 3 |
| 4. Navegación desde esta página | Paso 3.5 (solo si nav_analysis = true) |
| 5. Comparativa mobile vs desktop | Pasos 2, 3 y (si clarity disponible) parte del Paso 4 |
| 6. Hallazgos y recomendaciones | Requiere datos actuales — reejecutar pasos relevantes |

---

## MCP Tools

| Tool | Paso | Cuándo usar |
|---|---|---|
| `mcp__chrome-devtools__navigate_page` | 0.7 | Siempre — inspección visual del sitio |
| `mcp__chrome-devtools__take_screenshot` | 0.7 | Siempre — capturas desktop y mobile |
| `mcp__chrome-devtools__emulate` | 0.7 | Siempre — cambiar viewport a mobile y volver |
| `mcp__chrome-devtools__evaluate_script` | 0.7 | Siempre — extraer menú, CTAs e interactivos |
| `mcp__chrome-devtools__click` | 0.7 | Para expandir el menú mobile |
| `mcp__analytics-mcp__get_account_summaries` | 0.6 | Siempre — identificar propiedad GA4 |
| `mcp__analytics-mcp__run_report` | 2, 3.5 | Si ga4_property fue identificado |
| `{clarity_mcp}__query-analytics-dashboard` | 1, 3.5, 4 | Si clarity_mcp fue identificado |
| `mcp__pagespeed__analyze_pagespeed` | 3 | Siempre — mobile + desktop |

---

## Política de errores de MCP

Si un MCP falla, no está disponible, o no retorna datos, **nunca omitir silenciosamente**. En todos los casos:

1. Continuar con los demás pasos sin interrumpir el flujo
2. En la sección correspondiente del reporte, registrar:

```
> ⚠️ **Datos no disponibles** — {nombre del MCP} no respondió o no está instalado.
> Sin estos datos, {descripción del valor que aportaría}.
> Para obtener esta información, instala o verifica la configuración de `{nombre-mcp}`.
```

| MCP | Sección afectada | Valor que aportaría |
|---|---|---|
| `chrome-devtools` | Inspección visual (Paso 0.7) | Menú real del sitio, CTAs verificados, elementos interactivos vs decorativos |
| `clarity-{proyecto}` | Comportamiento (Paso 1) | Rage/dead clicks, quick backs, scroll depth para esta URL |
| `analytics-mcp` | Engagement GA4 (Paso 2) | Sesiones, bounce rate, duración, fuentes de tráfico |
| `pagespeed` | Performance CWV (Paso 3) | LCP, CLS, INP, FCP, TTFB mobile y desktop |

---

## Template de informe

Ver [references/ux-page-template.md](references/ux-page-template.md)
