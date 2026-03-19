---
name: webmometro-seo-page-opportunity
description: >
  Evalúa si una keyword candidata es viable para mejorar el rendimiento de una página existente.
  Parte de una hipótesis del usuario: "¿puede esta página capturar esta keyword?".
  Cruza demanda real, posición GSC actual, SERP competitivo, gap de contenido on-page,
  comportamiento de usuario (Clarity) y autoridad tópica del dominio.
  Genera un dictamen de viabilidad con Opportunity Score y plan de acción priorizado.
  Usar cuando el usuario mencione: "evaluar keyword para página", "oportunidad de keyword",
  "puede esta página rankear por", "qué keyword debería usar para esta página",
  "tiene oportunidad esta página", "reorientar contenido", "keyword candidata",
  "mejorar tráfico de esta página", "esta página no rankea bien", "qué keyword le conviene",
  "vale la pena atacar esta keyword", "factibilidad de keyword", "viabilidad de posicionamiento",
  "analiza si puedo posicionarme por", "compara estas keywords para esta página".
  NO usar para auditorías completas de página (on-page SEO, schema, performance) — derivar a
  webmometro-seo-page-audit. NO usar para investigación de keywords sin página específica —
  derivar a webmometro-seo-keywords.
metadata:
  version: 1.0.0
  argument-hint: "[URL de la página] [keyword candidata 1] [keyword candidata 2...]"
---

# webmometro-seo-page-opportunity — Viabilidad de Keyword para Página

Evalúa si una o más keywords candidatas son viables para mejorar el rendimiento de una página existente. No es un page audit completo — es un dictamen de oportunidad.

## Regla fundamental: scope

**Este skill recibe una página existente + keywords candidatas propuestas por el usuario.** Si el usuario pide:
- Auditoría completa de la página (on-page, schema, performance, backlinks) → derivar a `/webmometro-seo-page-audit`
- Investigación de keywords sin página específica → derivar a `/webmometro-seo-keywords`
- Diseño de cluster de contenido → al final de este análisis, derivar a `/webmometro-seo-clusters`

Máximo recomendado: 3 keywords candidatas por ejecución. Si el usuario propone más, pedir que priorice las 3 más relevantes.

---

## Configuración de ruta de reportes

Resolver `REPORTS_DIR` al iniciar:
- Si `$SEO_REPORTS_PATH` está definida → usar ese valor
- Si no → usar `{cwd}/reports` y advertir al usuario

Si `REPORTS_DIR` no existe, crearlo con `mkdir -p`.

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

## Flujo de ejecución

### Paso 0 — Contexto del negocio

Leer `$SEO_REPORTS_PATH/{dominio}/context.md` y, si existe, `$SEO_REPORTS_PATH/{dominio}/context/*.md` (prioridad sobre context.md).

Extraer y retener para usar en el análisis:
- **Pilares de contenido**: temas estratégicos donde el negocio quiere autoridad
- **Audiencia SEO objetivo**: para evaluar si la intención de la keyword candidata coincide
- **Keywords prioritarias** (top 20 GSC): para detectar si la candidata canibaliza keywords que ya funcionan
- **Páginas con potencial de crecimiento**: si la página auditada ya aparece aquí, usar el diagnóstico previo como punto de partida

La alineación estratégica es una dimensión del dictamen: una keyword técnicamente viable pero fuera de los pilares del negocio tiene menor prioridad que una alineada.

Si no existe context.md: advertir y continuar con análisis genérico sin puntuación de alineación estratégica.

### Paso 0.5 — Identificar MCP de Microsoft Clarity

1. Listar todos los MCPs disponibles que empiecen con `clarity-`
2. Elegir el que semánticamente más se parezca al dominio (comparación visual, no string matching)
3. Si hay ambigüedad: preguntar al usuario
4. Si ninguno corresponde: `clarity_mcp = null` — omitir Paso 5 sin error

### Paso 1 — Demanda y dificultad de cada keyword candidata

Para cada keyword candidata, ejecutar en paralelo:

```
mcp__dataforseo__keywords_google_ads_search_volume → volumen mensual, CPC, competencia
mcp__dataforseo__labs_google_bulk_keyword_difficulty → KD (0–100)
mcp__dataforseo__labs_google_search_intent → intención (informacional / transaccional / navegacional / comercial)
```

**Umbrales de viabilidad base:**

| Señal | ✅ Viable | ⚠️ Marginal | ❌ No viable |
|---|---|---|---|
| Volumen | ≥ 100/mes | 20–99/mes | < 20/mes |
| KD | ≤ 60 | 61–75 | > 75 |
| Intención | Alineada con la página | Parcialmente alineada | Contradice el tipo de página |

Estos umbrales son orientativos. Una keyword con KD 70 puede ser viable si el dominio tiene autoridad tópica consolidada en esa área. Una con KD 30 puede no ser viable si la intención es puramente informacional y la página es transaccional.

### Paso 2 — Posición actual en GSC y canibalización

```
mcp__gsc__search_analytics → dimensión "query", filtro: dominio, últimos 90 días
mcp__gsc__enhanced_search_analytics → keywords que llevan tráfico a la URL específica
mcp__dataforseo__labs_google_keywords_for_site → otras URLs del dominio que rankean para la keyword candidata
```

**Clasificación del punto de partida** (aplicar para cada keyword candidata):

| Posición actual de la página para la keyword | Diagnóstico | Acción |
|---|---|---|
| Pos 1–5 + volumen ≥ 100/mes | Ya bien posicionada | Detener análisis para esta keyword. Informar: "La página ya rankea bien para '{keyword}' — usa `/webmometro-seo-page-audit` para optimizar CTR y contenido." |
| Pos 1–5 + volumen < 100/mes | Posicionada pero keyword de bajo volumen | Continuar análisis completo. El problema es la keyword, no la página. Esta situación justifica evaluar la candidata propuesta. |
| Pos 6–15 | Primera página, no captura bien | Continuar. Analizar si el gap es de contenido o de autoridad. |
| Pos 16–30 | Página 2–3, base existente | Continuar. Mayor esfuerzo, pero hay base real para subir. |
| Sin ranking | Conquista desde cero | Continuar. La autoridad tópica del dominio determina si es alcanzable. |

**Canibalización:** si otra URL del dominio rankea mejor para la keyword candidata, esto es una señal de canibalización potencial. Registrar qué URL, en qué posición, y si la página auditada tiene sentido como destino consolidado.

### Paso 3 — SERP snapshot de cada keyword

```
mcp__dataforseo__serp_google_organic_live → location_code: 2152, language_code: es, depth: 10
```

Para cada keyword, extraer:
- Top 5 resultados: dominio, URL, título, snippet
- SERP features activas: AI Overview, Featured Snippet, PAA, Local Pack, Video, Shopping
- **Tipo de contenido dominante** en el top 5: ¿son páginas de tratamiento/servicio, artículos informativos, comparativas, listas, páginas de precio?
- Posición actual del dominio auditado en ese SERP (si aparece)

El tipo de contenido dominante define el **estándar de entrada**: si el top 5 son todas páginas de tratamiento con sección de precios y FAQ, la página candidata necesita ese formato para competir. Si son artículos informativos largos, el contenido actual puede estar bien estructurado pero necesita más profundidad.

**SERP Features Impact** (relevante para el dictamen de viabilidad):
- AI Overview activo → reduce CTR orgánico ~20–40% para todos los resultados
- Featured Snippet disponible → oportunidad de capturar posición 0 si el contenido responde directamente
- PAA activo → oportunidad de aparecer con FAQPage schema

### Paso 4 — Gap on-page (WebFetch de la página)

Hacer fetch de la URL. Extraer:
- H1 y estructura de headings (H2/H3)
- Word count estimado
- Subtemas cubiertos explícitamente
- Schema JSON-LD presente
- CTA visible

**Comparar vs el estándar del SERP (Paso 3):**
- ¿La página cubre los mismos subtemas que el top 3?
- ¿El word count es comparable?
- ¿Tiene el formato que el SERP premia (FAQ, comparativa, precios, etc.)?

**Clasificar el esfuerzo de cierre del gap:**
- **Ajuste moderado** (< 4h): agregar secciones, expandir contenido existente, ajustar H1/título
- **Reescritura mayor** (4–12h): reestructurar completamente, cambiar ángulo del contenido, tipo de página diferente
- **Nueva página** (> 12h o cambio de intención): la página actual tiene un propósito distinto al que requiere la keyword — mejor crear una URL nueva

### Paso 5 — Comportamiento de usuario (Clarity)

**Solo si `clarity_mcp` fue identificado en el Paso 0.5.**

```
{clarity_mcp}__query-analytics-dashboard →
  "Quick backs, scroll depth, rage clicks, dead clicks para {URL}, últimos 30 días"

{clarity_mcp}__list-session-recordings →
  filtrar por URL, ordenar SessionDuration_DESC, count: 3
```

**Señales para el dictamen:**

| Métrica | Señal favorable para reorientación | Señal de alerta |
|---|---|---|
| Quick backs > 40% | La intención actual no se satisface → cambio de enfoque tiene sentido | — |
| Scroll depth < 50% | El contenido no engancha → reestructurar o cambiar ángulo | — |
| Duración sesión < 30s | Usuarios rebotan rápido → contenido no responde la intención | Puede ser señal de que el tráfico actual es de la keyword equivocada |
| 0 rage/dead clicks | UX base está bien → cambios de contenido son seguros | — |

Si Clarity no retorna datos para la URL: anotar "Sin datos Clarity para esta URL" y continuar.

### Paso 6 — Topic authority del dominio

```
mcp__dataforseo__labs_google_keywords_for_site →
  dominio + keyword candidata como semilla, filtrar resultados temáticamente relacionados

mcp__dataforseo__labs_google_related_keywords →
  keyword candidata → obtener keywords semánticamente relacionadas
```

Con esto determinar:
- **Nivel de autoridad tópica**: cuántas URLs del dominio rankean en el área semántica de la keyword
  - **Consolidada**: 5+ páginas rankeando en esa área → el dominio puede competir con optimizaciones
  - **Emergente**: 2–4 páginas → viable pero necesita refuerzo de cluster
  - **Sin base**: 0–1 páginas → conquista desde cero, mayor riesgo, más tiempo
- **Páginas existentes** que podrían apoyar con links internos hacia la página candidata
- **Subtemas sin cobertura**: qué áreas semánticas relacionadas no tienen página en el dominio (a alto nivel — para arquitectura detallada del cluster, usar `/webmometro-seo-clusters`)

### Paso 7 — Opportunity Score y dictamen

Calcular el **Opportunity Score** (0–100) para cada keyword:

| Dimensión | Peso | Cómo puntuar |
|---|---|---|
| Demanda (volumen × alineación de intención) | 25% | Volumen ≥ 500: 100 · ≥ 100: 70 · ≥ 20: 40 · < 20: 0. Ajustar −20 si intención no alineada con el tipo de página. |
| Competencia (inverso KD + impacto SERP features) | 20% | KD ≤ 30: 100 · ≤ 50: 75 · ≤ 60: 55 · ≤ 75: 30 · > 75: 0. Ajustar −15 si AI Overview activo. |
| Punto de partida GSC | 20% | Pos 6–10: 90 · Pos 11–20: 65 · Pos 21–30: 40 · Sin ranking: 20. Ajustar +20 si hay base de impresiones (> 500/mes aunque CTR sea bajo). Si hay canibalización: −30. |
| Gap on-page (esfuerzo vs impacto) | 20% | Ajuste moderado: 80 · Reescritura mayor: 45 · Nueva página: 20. |
| Topic authority | 15% | Consolidada: 100 · Emergente: 60 · Sin base: 20. |

**Alineación estratégica** (modificador del score final, solo si context.md disponible):
- Keyword dentro de pilares prioritarios del negocio: +10
- Keyword en pilares de media prioridad: +0
- Keyword fuera de pilares definidos: −10

**Veredicto:**
- ✅ **Oportunidad clara** (score ≥ 65): viable con acciones directas
- ⚠️ **Viable con trabajo previo** (score 40–64): requiere inversión antes de poder competir (cluster, reescritura, resolución de canibalización)
- ❌ **No viable ahora** (score < 40): explicar la razón principal y cuándo revisitar (ej: "revisar cuando el dominio tenga 3+ páginas de soporte en esta área")

**Recomendaciones específicas de contenido**: generar solo si el veredicto es ✅ o ⚠️ **y** el gap es "ajuste moderado". Si el gap requiere reescritura mayor o nueva página, indicar el enfoque a alto nivel sin detallar cambios específicos de contenido.

---

## Output — Reporte

Guardar en:
```
$SEO_REPORTS_PATH/{dominio}/opportunities/{fecha}-opportunity-{slug}.md
```
Donde `{slug}` = keyword candidata principal en kebab-case (ej: `hilos-tensores-pdo`).

Generar el reporte usando el template en `references/opportunity-template.md`. Leer el template antes de generar el reporte para mantener consistencia de estructura entre ejecuciones.

### Estructura del reporte

```
# Oportunidad de Keyword — {slug}
**Dominio**: {dominio} | **URL**: {URL}
**Keywords evaluadas**: {keyword1}, {keyword2}, ...
**Fecha**: {fecha}

---

## Resumen ejecutivo

| Keyword | Volumen | KD | Pos. actual | Opp. Score | Veredicto |
|---|---|---|---|---|---|
| keyword1 | X/mes | XX | pos XX | XX/100 | ✅/⚠️/❌ |

## Análisis por keyword

### [Keyword 1]

#### Demanda y dificultad
...

#### Punto de partida GSC
...

#### SERP snapshot
...

#### Gap on-page
...

#### Comportamiento de usuario (Clarity)
...

#### Topic authority
...

#### Opportunity Score: XX/100 — [Veredicto]

## Comparativa (si hay múltiples keywords)

| Dimensión | Keyword 1 | Keyword 2 | Keyword 3 |
|---|---|---|---|
| Demanda | | | |
| Competencia | | | |
| Punto de partida | | | |
| Gap on-page | | | |
| Topic authority | | | |
| **Score total** | | | |
| **Veredicto** | | | |

**Keyword recomendada**: {keyword} — {razón en una línea}

## Plan de acción

### 🔴 Requisito previo (si aplica)
- Resolver canibalización: ...
- Construir cluster: ...

### 🟠 Cambios on-page prioritarios
- ...

### 🟡 Acciones de refuerzo
- Links internos: páginas que deberían enlazar aquí + anchor sugerido
- Cluster: N subtemas sin cobertura → usar `/webmometro-seo-clusters {dominio}` para arquitectura detallada
```

---

## Política de errores de MCP

Si un MCP falla o no retorna datos, nunca omitir silenciosamente. En la sección afectada del reporte, registrar:

```
> ⚠️ **Datos no disponibles** — {nombre del MCP} no respondió o no está instalado.
> Sin estos datos, {descripción del valor que aportaría}.
> Para obtener esta información, instala o verifica la configuración de `{nombre-mcp}`.
```

Si una dimensión del Opportunity Score no tiene datos, excluirla del cálculo y redistribuir el peso entre las dimensiones disponibles. Indicarlo en el reporte.

| MCP | Dimensión afectada | Valor que aportaría |
|---|---|---|
| `gsc` | Punto de partida GSC, canibalización | Posición real de la página para la keyword, detección de URLs que compiten |
| `dataforseo` (search_volume) | Demanda | Volumen mensual real, CPC, competencia |
| `dataforseo` (keyword_difficulty) | Competencia | KD objetivo para calibrar esfuerzo |
| `dataforseo` (search_intent) | Alineación de intención | Clasificación de intención para validar fit con la página |
| `dataforseo` (serp) | SERP snapshot | Competidores reales, features activas, estándar de entrada |
| `dataforseo` (labs) | Topic authority, canibalización | Cobertura tópica del dominio, detección de URLs competidoras |
| `clarity-{proyecto}` | Comportamiento de usuario | Quick backs, scroll depth, señales de intención no satisfecha |

---

## MCP Tools

| Tool | Paso | Cuándo usar |
|---|---|---|
| `mcp__dataforseo__keywords_google_ads_search_volume` | 1 | Siempre, para cada keyword |
| `mcp__dataforseo__labs_google_bulk_keyword_difficulty` | 1 | Siempre, para cada keyword |
| `mcp__dataforseo__labs_google_search_intent` | 1 | Siempre, para cada keyword |
| `mcp__gsc__search_analytics` | 2 | Siempre |
| `mcp__gsc__enhanced_search_analytics` | 2 | Siempre |
| `mcp__dataforseo__labs_google_keywords_for_site` | 2 + 6 | Siempre — canibalización (Paso 2) y topic authority (Paso 6) |
| `mcp__dataforseo__serp_google_organic_live` | 3 | Siempre, para cada keyword |
| `WebFetch` | 4 | Siempre |
| `{clarity_mcp}__query-analytics-dashboard` | 5 | Si clarity_mcp identificado |
| `{clarity_mcp}__list-session-recordings` | 5 | Si clarity_mcp identificado |
| `mcp__dataforseo__labs_google_related_keywords` | 6 | Siempre |
