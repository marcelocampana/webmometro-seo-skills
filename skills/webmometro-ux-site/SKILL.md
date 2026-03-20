---
name: webmometro-ux-site
description: |
  Genera un informe UX del sitio completo orientado al equipo de diseño.
  Analiza comportamiento de usuarios agregado: frustración, engagement, flujos
  de navegación, diferencias por dispositivo y performance técnica, usando
  Google Analytics 4 y Microsoft Clarity.
  Usar cuando el usuario mencione: "informe ux del sitio", "reporte ux del sitio",
  "análisis de comportamiento del sitio", "ux site", "cómo se comportan los
  usuarios en el sitio", "qué páginas frustran a los usuarios", "experiencia de
  usuario del sitio", "diagnóstico ux", "ux report", "informe de usabilidad",
  "análisis ux", "comportamiento de usuarios", "heatmap del sitio", "rage clicks
  del sitio", "scroll depth del sitio", "frustración de usuarios".
  NO usar para análisis de una página específica — derivar a webmometro-ux-page.
metadata:
  version: 1.0.0
  argument-hint: "[dominio]"
---

# webmometro-ux-site — Informe UX del Sitio

Genera un informe de experiencia de usuario para el sitio completo, orientado al equipo de diseño. Combina datos de Google Analytics 4 (comportamiento agregado) y Microsoft Clarity (señales de frustración y engagement).

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

**Este skill es para el SITIO COMPLETO.** Si el usuario pide análisis de una página específica → derivar:
> "Para analizar la UX de una página específica, usa `/webmometro-ux-page [URL]` — ese skill cruza Clarity y GA4 con foco en una sola URL."

---

## Configuración de ruta de reportes

Al iniciar, resolver la ruta base de reportes:

- Si `$SEO_REPORTS_PATH` está definida → usar ese valor como `REPORTS_DIR`
- Si no está definida → usar `{cwd}/reports` como `REPORTS_DIR` y advertir al usuario:
  > "No encontré `SEO_REPORTS_PATH`. Guardando reportes en `{cwd}/reports`. Para usar otra ubicación, define `SEO_REPORTS_PATH` en `.claude/settings.json`."

Si `REPORTS_DIR` no existe, crearlo con `mkdir -p`.

---

## Control de frescura del reporte

Antes de iniciar, verificar si ya existe un reporte en:

```
$SEO_REPORTS_PATH/{dominio}/ux/ux-site-{fecha}.md
```

Buscar el archivo más reciente con patrón `ux-site-*.md` en ese directorio.

Si existe un reporte con **menos de 15 días** desde hoy:

> "Ya existe un informe UX de `{dominio}` generado el {fecha} ({N} días). ¿Qué quieres hacer?
>
> **R** — Regenerar el informe completo
> **C** — Cancelar
>
> O indica el número de la sección que quieres actualizar:
> 1. Audiencia y dispositivos
> 2. Páginas con mayor frustración
> 3. Engagement por página
> 4. Flujos de navegación y puntos de salida
> 5. Navegación desde páginas distribuidoras (clics del menú)
> 6. Performance técnica (CWV)
> 7. Errores JavaScript
> 8. Plan de acción"

Si el usuario responde con números, ejecutar solo los pasos necesarios y actualizar esas secciones en el archivo existente. Si el reporte tiene **15 días o más**, o no existe → ejecutar el flujo completo.

---

## Flujo de ejecución

### Paso 0 — Contexto del negocio

Verificar si existe `$SEO_REPORTS_PATH/{dominio}/site-profile.md`:

- **Si existe**: leerlo. Extraer: tipo de negocio, audiencias, objetivo principal del sitio. Este contexto permite interpretar los datos de comportamiento en función de los objetivos reales del negocio.
- **Si no existe**: continuar sin él y advertir:
  > "No encontré el perfil del negocio para `{dominio}`. El análisis será genérico. Para obtener hallazgos contextualizados, genera el perfil con `/webmometro-seo-site-profile {dominio}`."

### Paso 0.5 — Identificar MCP de Microsoft Clarity

1. Listar todos los MCPs disponibles que empiecen con `clarity-`
2. Elegir el que semánticamente más se parezca al dominio o nombre del negocio (comparación visual/semántica — ej: `observatoriodelcancer.cl` → `clarity-observatorio-del-cancer`)
3. Si hay ambigüedad entre dos candidatos, preguntar al usuario cuál corresponde
4. Si ninguno corresponde: `clarity_mcp = null` — omitir todos los pasos de Clarity sin error

### Paso 0.6 — Identificar propiedad GA4

```
mcp__analytics-mcp__get_account_summaries → listar todas las propiedades GA4 disponibles
```

Seleccionar la propiedad que semánticamente más se parezca al dominio o nombre del negocio. Guardar como `ga4_property_id`.

Si el tool falla con error de reautenticación (`Reauthentication is needed` o `gcloud auth`):
- `ga4_property = null` — omitir todos los pasos GA4
- Ejecutar inmediatamente en terminal (sin pedirle nada al usuario primero):

```bash
gcloud auth application-default login \
  --scopes https://www.googleapis.com/auth/analytics.readonly,https://www.googleapis.com/auth/cloud-platform \
  --client-id-file="/Users/marcelocampana/Projects/mcps/credentials/client_secret_728451328493-7iui8q0bbpicgb3fdukfe84goa5emsvd.apps.googleusercontent.com.json"
```

- El comando abre el navegador automáticamente. Avisar al usuario:

```
⚠️  GA4 requiere re-autenticación

Abrí el navegador para autorizar el acceso a Google Analytics.
Por favor autoriza con tu cuenta de Google y responde "listo" cuando termines.
```

Esperar respuesta del usuario. Si responde "listo" o similar → reintentar `mcp__analytics-mcp__get_account_summaries` y continuar con los pasos GA4. Si no responde o cancela → registrar en el informe:

```
> ⚠️ **Datos de GA4 no disponibles** — Token de autenticación expirado.
> Para obtener estos datos, ejecuta el comando de re-autenticación y regenera las secciones afectadas.
```

Si no hay ninguna propiedad disponible por otro motivo: `ga4_property = null` — omitir todos los pasos GA4 sin error, registrando el bloque ⚠️ correspondiente.

---

### Paso 1 — Audiencia y dispositivos (GA4)

**Solo si `ga4_property` fue identificado.**

Ejecutar en paralelo:

```
mcp__analytics-mcp__run_report →
  property_id: ga4_property_id (número entero, sin comillas)
  dimensions: ["deviceCategory"]          ← strings planos, NO objetos {name:...}
  metrics: ["sessions", "totalUsers", "bounceRate", "averageSessionDuration", "screenPageViews"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]

mcp__analytics-mcp__run_report →
  property_id: ga4_property_id
  dimensions: ["newVsReturning"]
  metrics: ["sessions", "bounceRate", "averageSessionDuration"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]
```

**Importante**: La API GA4 espera dimensiones y métricas como **strings planos** en listas — nunca como objetos `{"name": "..."}`. Usar snake_case en los parámetros del tool (`property_id`, `date_ranges`, `order_bys`). Ejecutar las llamadas GA4 de a **máximo 3 en paralelo** para evitar errores de reauthentication.

Registrar:
- Tabla comparativa: mobile / tablet / desktop (sesiones, bounce rate, duración promedio)
- Tabla new vs returning: sesiones, bounce rate, duración promedio
- Identificar si hay degradación significativa en mobile vs desktop (bounce >20% mayor o duración >30% menor)

### Paso 2 — Engagement por página (GA4 + Clarity)

**GA4** — si `ga4_property` disponible:

```
mcp__analytics-mcp__run_report →
  property_id: ga4_property_id
  dimensions: ["pagePath"]
  metrics: ["sessions", "bounceRate", "averageSessionDuration", "screenPageViews"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]
  order_bys: [{"metric": {"metric_name": "sessions"}, "desc": true}]
  limit: 20
```

**Clarity** — si `clarity_mcp` disponible, ejecutar en paralelo:

```
{clarity_mcp}__query-analytics-dashboard →
  "Top páginas por scroll depth, últimos 30 días"

{clarity_mcp}__query-analytics-dashboard →
  "Top páginas por quick backs, últimos 30 días"
```

Cruzar los datos para identificar:
- **Páginas estrella**: bounce bajo + scroll depth alto + duración alta → buen engagement
- **Páginas problema**: bounce alto + quick backs + scroll depth bajo → frustración o mismatch de contenido
- **Páginas con potencial**: tráfico alto pero engagement medio → oportunidad de mejora de diseño

### Paso 3 — Señales de frustración (Clarity)

**Solo si `clarity_mcp` fue identificado.**

Ejecutar en paralelo:

```
{clarity_mcp}__query-analytics-dashboard →
  "Rage clicks por página, últimos 30 días"

{clarity_mcp}__query-analytics-dashboard →
  "Dead clicks por página, últimos 30 días"

{clarity_mcp}__query-analytics-dashboard →
  "Quick backs por página, últimos 30 días"
```

Umbrales de alarma para clasificar cada página:
- Quick backs > 40% → 🔴 Mismatch de contenido o expectativa no satisfecha
- Rage clicks > 5% → 🔴 Frustración activa — elemento no funciona como el usuario espera
- Dead clicks > 10% → 🟠 Confusión de UX — elemento parece interactivo pero no lo es

Ordenar páginas de mayor a menor nivel de frustración combinado.

### Paso 4 — Flujos de navegación y puntos de salida (GA4)

**Solo si `ga4_property` fue identificado.**

Ejecutar en paralelo:

```
mcp__analytics-mcp__run_report →
  property_id: ga4_property_id
  dimensions: ["sessionDefaultChannelGroup"]
  metrics: ["sessions", "bounceRate", "averageSessionDuration", "totalUsers"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]

mcp__analytics-mcp__run_report →
  property_id: ga4_property_id
  dimensions: ["pagePath"]
  metrics: ["exits", "sessions"]
  date_ranges: [{"start_date": "30daysAgo", "end_date": "yesterday"}]
  order_bys: [{"metric": {"metric_name": "exits"}, "desc": true}]
  limit: 15
```

Ejecutar estas dos llamadas en una tanda separada (no junto con otras GA4) para evitar reauthentication errors.

Registrar:
- Calidad por canal: qué canales traen usuarios más engaged (menor bounce, mayor duración)
- Top páginas de salida: URL + tasa de salida — identificar páginas donde los usuarios abandonan el sitio

### Paso 4.5 — Navegación desde páginas distribuidoras

Identificar las **5 páginas más visitadas** del sitio a partir de los datos del Paso 2 (GA4, top por sesiones). Para cada una de estas páginas, analizar si está funcionando como distribuidor de tráfico efectivo hacia el resto del sitio.

**Solo si `clarity_mcp` fue identificado.** Ejecutar una consulta por cada una de las top 5 páginas:

```
{clarity_mcp}__query-analytics-dashboard →
  "Top URLs clicadas desde {URL_página_1} en desktop y mobile, últimos 30 días"

{clarity_mcp}__query-analytics-dashboard →
  "Top URLs clicadas desde {URL_página_2} en desktop y mobile, últimos 30 días"

... (repetir para las 5 páginas)
```

**Importante**: ejecutar estas consultas de a máximo 3 en paralelo para evitar errores de rate limit.

Cruzar con los datos de sesiones de GA4 del Paso 2: para cada URL de destino que aparece en los clics de Clarity, verificar su engagement (bounce, duración) en la tabla de páginas ya obtenida.

Registrar para cada página distribuidora:

```
### {URL página distribuidora} — distribución de clics de navegación

| Destino | Clics desktop | Clics mobile | Sesiones GA4 | Bounce GA4 | Diagnóstico |
|---|---|---|---|---|---|
| {url} | {n} | {n} | {n} | {%} | {emoji} |
```

Diagnóstico por fila:
- Clics altos + bounce bajo → ✅ Enlace efectivo — genera interés y la página destino lo sostiene
- Clics altos + bounce alto → 🟠 El enlace capta interés pero la página destino no cumple la expectativa
- Clics bajos en mobile vs desktop → 🔴 Enlace no visible o accesible en mobile
- Clics muy bajos en ambos dispositivos → 🟡 Sección del menú con bajo interés — evaluar si el label comunica el valor correctamente

Al final de este paso, sintetizar:
- ¿Qué secciones del menú/navegación generan más tráfico interno?
- ¿Hay asimetría relevante entre mobile y desktop en algún destino clave?
- ¿Alguna página importante del sitio recibe pocos clics de navegación interna pero tiene buen engagement cuando llegan usuarios? → oportunidad de mejorar su visibilidad en el menú

### Paso 5 — Performance técnica (CWV)

```
mcp__pagespeed__analyze_pagespeed → mobile para la homepage del dominio
mcp__pagespeed__analyze_pagespeed → desktop para la homepage del dominio
```

Si `clarity_mcp` disponible:
```
{clarity_mcp}__query-analytics-dashboard →
  "Core Web Vitals LCP y CLS del sitio, últimos 30 días"
```

El tool `analyze_pagespeed` retorna: score global (0-100) y lista de `topImprovements` con título, descripción e impacto. Los valores individuales de LCP/CLS/INP de campo (`loadingExperience`) pueden venir como "N/A" si el sitio no tiene suficientes datos reales de Chrome UX Report.

Registrar siempre:
- Score PageSpeed mobile y desktop
- Top 3 oportunidades de mejora con su impacto

Si los valores de CWV de campo están disponibles (no "N/A"), registrar también:
- LCP — umbral: ≤2.5s ✅ / 2.5-4s ⚠️ / >4s 🔴
- CLS — umbral: ≤0.1 ✅ / 0.1-0.25 ⚠️ / >0.25 🔴
- INP — umbral: ≤200ms ✅ / 200-500ms ⚠️ / >500ms 🔴

Si los valores de campo son "N/A", complementar con los datos de Clarity (LCP/CLS p75 del sitio).

### Paso 6 — Errores JavaScript (Clarity)

**Solo si `clarity_mcp` fue identificado.**

```
{clarity_mcp}__query-analytics-dashboard →
  "JavaScript errors del sitio, últimos 30 días"
```

Listar errores con frecuencia. Anotar si algún error ocurre en páginas con alto rage clicks (correlación probable con frustración).

### Paso 7 — Generar informe

Calcular el **UX Health Score**:

| Categoría | Peso | Cómo puntuar |
|---|---|---|
| Frustración (rage/dead clicks, quick backs) | 30% | Sin páginas con alarmas = 100; cada alarma 🔴 resta 15pts, 🟠 resta 8pts |
| Engagement (scroll depth, duración, bounce) | 25% | Basado en % de páginas top con engagement positivo |
| Performance CWV | 20% | Promedio de scores PageSpeed mobile + desktop |
| Paridad mobile/desktop | 15% | Diferencia de bounce y duración entre dispositivos |
| Errores JavaScript | 10% | Sin errores = 100; cada error con >10 ocurrencias resta 20pts |

Si una categoría no tiene datos por fallo de MCP → excluirla del cálculo y anotarla con `— (sin datos)`.

Escala: 🟢 Excelente 85-100 / 🟡 Bueno 70-84 / 🟠 Necesita mejoras 50-69 / 🔴 Crítico 0-49

Generar el informe usando el template en `references/ux-site-template.md`.

Guardar en: `$SEO_REPORTS_PATH/{dominio}/ux/ux-site-{fecha}.md`

---

## Mapeo sección → pasos (para regeneraciones parciales)

| Sección | Pasos a ejecutar |
|---|---|
| 1. Audiencia y dispositivos | Paso 1 |
| 2. Páginas con mayor frustración | Paso 3 |
| 3. Engagement por página | Paso 2 |
| 4. Flujos de navegación | Paso 4 |
| 5. Navegación desde páginas distribuidoras | Paso 4.5 (requiere Paso 2 para top 5 páginas) |
| 6. Performance técnica | Paso 5 |
| 7. Errores JavaScript | Paso 6 |
| 8. Plan de acción | Requiere datos actuales — reejecutar pasos relevantes |

---

## MCP Tools

| Tool | Paso | Cuándo usar |
|---|---|---|
| `mcp__analytics-mcp__get_account_summaries` | 0.6 | Siempre — identificar propiedad GA4 |
| `mcp__analytics-mcp__run_report` | 1, 2, 4 | Si ga4_property fue identificado |
| `{clarity_mcp}__query-analytics-dashboard` | 2, 3, 4.5, 5, 6 | Si clarity_mcp fue identificado |
| `mcp__pagespeed__analyze_pagespeed` | 5 | Siempre |

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
| `analytics-mcp` | Audiencia, Engagement, Flujos | Sesiones, bounce rate, duración, dispositivos |
| `clarity-{proyecto}` | Frustración, Engagement, Errores JS | Rage/dead clicks, quick backs, scroll depth |
| `pagespeed` | Performance CWV | LCP, CLS, INP mobile y desktop |

---

## Template de informe

Ver [references/ux-site-template.md](references/ux-site-template.md)
