# Auditoría SEO Completa — observatoriodelcancer.cl
**Fecha de auditoría**: 2026-03-17
**Tipo de negocio**: Fundación / ONG — Observatorio de salud oncológica, Chile
**Plataforma**: Wix (Thunderbolt renderer)
**Servidor**: Pepyaka (Wix hosting) | IP: 34.160.37.117
**Certificado SSL**: Google Trust Services WR1 | Válido hasta 2026-05-04

---

## Executive Summary

### SEO Health Score: 61 / 100

| Categoría | Peso | Score | Puntos |
|---|---|---|---|
| Technical SEO | 25% | 62/100 | 15.5 |
| Content Quality | 25% | 55/100 | 13.8 |
| On-Page SEO | 20% | 65/100 | 13.0 |
| Schema / Structured Data | 10% | 70/100 | 7.0 |
| Performance / Core Web Vitals | 10% | 60/100 | 6.0 |
| Images | 5% | 65/100 | 3.3 |
| AI Search Readiness | 5% | 55/100 | 2.8 |
| **TOTAL** | **100%** | — | **61.4** |

### Tipo de negocio detectado
ONG / Fundación de salud pública enfocada en cáncer en Chile. Produce investigación, informes, campañas de sensibilización, e incide en políticas públicas oncológicas. Modelo de autoridad temática informacional con captación de donaciones y consultoría.

### Top 5 Issues Críticos

1. **Sin H1 en homepage y múltiples páginas clave** — La página de inicio no tiene H1. `/triplenegativo`, `/cancerdemamaysubtipos/her2positivo` tampoco tienen H1. Rompe la jerarquía semántica y señalización de relevancia.
2. **14 páginas de la sección "Todo sobre cáncer" sin meta description** — `/todo-sobre-cancer-1/cáncer-de-mama`, `/todo-sobre-cancer-1/i-am-a-title-01` y otras ~12 páginas tienen `metaDesc: null`. Estas páginas tienen 1.900+ palabras de contenido valioso y están totalmente sub-optimizadas.
3. **URLs con placeholders de producción en sitemap** — 4 URLs con slug `i-am-a-title-0X` están en el sitemap público y siendo indexadas. Son páginas con contenido real pero URLs sin sentido semántico.
4. **Sin og:image en ninguna página** — Cero páginas tienen `og:image` configurado. El sharing social genera previews vacíos, reduciendo CTR en redes sociales.
5. **164 recursos cargados en homepage — 103 scripts JS** — La homepage carga 103 peticiones de scripts. Aunque el FCP medido es 216ms (en red rápida local), bajo condiciones móviles reales este volumen de JS es un riesgo severo de performance.

### Top 5 Quick Wins

1. **Agregar og:image a todas las páginas** — Wix permite configurar imagen OG por página. Implementar en las 31 páginas del sitemap principal. Impacto: CTR social inmediato.
2. **Agregar meta description a la sección "Todo sobre cáncer"** — 14 páginas sin meta description con contenido extenso. Escribir 14 descripciones únicas de 140-160 caracteres. Impacto: CTR en SERP mejorado en días.
3. **Corregir slugs placeholder** — Cambiar `/todo-sobre-cancer-1/i-am-a-title-01` → `/todo-sobre-cancer-1/cancer-cervicouterino` (y los otros 3). Impacto: indexación semántica correcta.
4. **Agregar H1 a homepage** — El primer heading visible en el DOM es H2. Añadir un H1 claro como "Observatorio del Cáncer: Datos, Investigación y Equidad Oncológica en Chile". Impacto: señal de relevancia primaria.
5. **Agregar BlogPosting schema a artículos del blog** — El blog tiene 127 artículos sin schema Article/BlogPosting. Implementar vía Wix structured data o plugin. Impacto: elegibilidad para rich results y AI Overviews.

---

## 1. Technical SEO (25%)

### 1.1 Crawlabilidad e Indexabilidad

**robots.txt** — Correcto y bien estructurado:
```
User-agent: *
Allow: /
Disallow: *?lightbox=
User-agent: AdsBot-Google-Mobile / AdsBot-Google
Disallow: /_partials* / /pro-gallery-webapp/*
User-agent: PetalBot → Disallow: /
User-agent: dotbot / AhrefsBot → Crawl-delay: 10
Sitemap: https://www.observatoriodelcancer.cl/sitemap.xml
```
- PetalBot bloqueado (correcto — bot agresivo de Huawei).
- Crawl-delay para bots de terceros (buena práctica).
- Sin bloqueos problemáticos para Googlebot.

**Sitemap** — Estructura de índice con 7 sitemaps hijo:
| Sitemap | Observación |
|---|---|
| `pages-sitemap.xml` | 31 URLs, todas con lastmod 2026-03-16 — OK |
| `blog-posts-sitemap.xml` | 127 URLs, fechas 2025-06-23 a 2026-03-16 — OK |
| `dynamic-todo-sobre-cancer-1-sitemap.xml` | 14 URLs, incluye 4 slugs `i-am-a-title-0X` — PROBLEMA |
| `store-products-sitemap.xml` | Presente (sin tienda activa aparente) |
| `store-categories-sitemap.xml` | Presente (sin tienda activa aparente) |
| `blog-categories-sitemap.xml` | Categorías de blog |
| `dynamic-servicios-de-consultoria-paginas-sitemap.xml` | Páginas de consultoría |

**Problema detectado**: 4 URLs con slugs placeholder en sitemap público:
- `/todo-sobre-cancer-1/i-am-a-title-01` (contenido: Cáncer cervicouterino, 1.920 palabras)
- `/todo-sobre-cancer-1/i-am-a-title-02`
- `/todo-sobre-cancer-1/i-am-a-title-03`
- `/todo-sobre-cancer-1/i-am-a-title-04`

**Problema adicional**: `store-products-sitemap.xml` y `store-categories-sitemap.xml` presentes sin una tienda activa. Si contienen URLs huérfanas, consumirán crawl budget inútilmente.

### 1.2 HTTPS y Seguridad

- HTTPS activo y válido ✓
- Certificado Google Trust Services, expira 2026-05-04 (renovación automática Wix) ✓
- HTTP/2 activo ✓
- HSTS activo (confirmado por Lighthouse) ✓
- Redirección HTTPS funcionando ✓
- CSP efectivo contra XSS ✓ (Lighthouse: score 1)
- Clickjacking mitigation con XFO/CSP ✓
- Origin isolation con COOP ✓
- **Cookies de terceros**: 8 cookies de terceros detectadas (Microsoft Clarity: SM, MR, ANONCHK, etc.) — bajo presión regulatoria GDPR/Ley 19.628 Chile.

### 1.3 Redirecciones y Canonicalización

- Canonicals presentes y correctos en todas las páginas revisadas ✓
- `observatoriodelcancer.cl` redirige a `www.observatoriodelcancer.cl` con 301 ✓
- No se detectaron redirect chains ni canonical chains ✓
- **Test de canonicalización**: status 403 en task más reciente de OnPage (posible protección anti-bot de Wix). El task previo (observatoriodelcancer.cl sin www) muestra canonicalización_status_code: 301 ✓

### 1.4 Plataforma: Wix y JavaScript Rendering

El sitio corre sobre Wix Thunderbolt con renderizado client-side. Implicaciones:
- El HTML raw no contiene meta tags — son inyectados por JS post-hydratación.
- Googlebot renderiza JS (Chromium-based), por lo que el contenido es indexable.
- Sin embargo, el tiempo de renderizado es relevante para el crawl budget en páginas de baja prioridad.
- **103 scripts JS** cargados en homepage — carga extrema para bots con tiempo limitado.
- **Wix genera meta tags dinámicamente** — confirmado: title, description, canonical, og tags todos presentes en DOM renderizado.

### 1.5 Hreflang

- No hay hreflang implementado.
- El sitio es monolingüe (español Chile). No es un problema urgente, pero podría ser útil agregar `hreflang="es-CL"` self-referencing para señalización geográfica explícita.

---

## 2. Content Quality (25%)

### 2.1 Tipo y profundidad de contenido

El sitio publica varios tipos de contenido:

| Sección | Páginas | Palabras estimadas | Calidad |
|---|---|---|---|
| "Todo sobre cáncer" | ~14 tipos | 1.800-2.000 c/u | Alta — contenido médico estructurado con H1, H2 semánticos |
| Páginas de iniciativas (Triple Negativo, HER2, Cáncer de Mama) | ~8 | 1.000-1.700 | Alta — datos, estadísticas, cobertura GES |
| Blog | 127 artículos | Variable | Media-alta — falta estructura de schema |
| Homepage | 1 | ~367 palabras | Baja — contenido escaso para página de autoridad |

### 2.2 E-E-A-T Assessment

**Experience**: La organización es una fundación reconocida en el ecosistema oncológico chileno. Colabora con especialistas médicos, produce el "Primer Registro Nacional de Mujeres en Espera de Reconstrucción Mamaria", y organiza eventos con autoridades (Ceremonia Anual, Conversaciones Impostergables).

**Expertise**:
- Contenido médico revisado por comité asesor científico (/gobernanza lista equipo)
- Revista ROC (roc.observatoriodelcancer.cl) — publicación especializada
- Podcast "Estadio Cero"
- **Debilidad**: los artículos del blog no muestran byline de autor visible en DOM, ni fecha de publicación indexable en schema. Esto debilita E-A-T para Google en contenido YMYL (salud).

**Authoritativeness**:
- Ranking #1 para "observatorio del cancer chile" ✓
- Ranking #9 para "cancer de mama chile" (SV alto competitivo) ✓
- Ranking #6 para "triple negativo cancer de mama" ✓
- Verificado en Google Search Console (meta tag presente) ✓
- Presencia en oncored.org como organización miembro ✓
- Instagram 9.8K seguidores, LinkedIn 1.8K, Facebook 4.9K ✓

**Trustworthiness**:
- HTTPS ✓, política de privacidad presente ✓
- Contacto visible ✓ (contacto@observatoriodelcancer.cl)
- Gobernanza pública listada ✓
- Sin schema de Organización con datos de contacto completos (telephone, address) — debilidad.

### 2.3 Contenido delgado (Thin Content)

- **Homepage**: 367 palabras en body text. Para una página de autoridad de una ONG de salud, es insuficiente. Las páginas que rankean bien en health topics suelen tener 800-1.500 palabras en homepage.
- **Página /publicaciones**: 219 palabras — actúa como índice, lo cual es aceptable si los documentos son accesibles.
- **Página /blog**: 228 palabras — solo muestra 2 posts visibles. Podría ser JS-lazy; sin embargo el DOM renderizado es escaso.
- **Páginas "Todo sobre cáncer"** (14 páginas): Contenido sustancial (1.800-2.000 palabras), bien estructurado con H1 y múltiples H2. Es el contenido de mayor profundidad del sitio.

### 2.4 Contenido duplicado

- OnPage score: `duplicate_title: 0`, `duplicate_description: 0`, `duplicate_content: 0` — sin duplicados detectados.
- Todas las páginas tienen canonical self-referencing único.

---

## 3. On-Page SEO (20%)

### 3.1 Title Tags

| Página | Title | Longitud | Evaluación |
|---|---|---|---|
| Homepage | "Observatorio del Cáncer Chile: Datos, Investigación y Equidad en Salud Oncológica" | ~82 chars | Demasiado largo (>60 chars) — se truncará en SERP |
| /cancerdemamaysubtipos | "Cáncer de mama en Chile: subtipos, detección y cobertura" | ~57 chars | Óptimo ✓ |
| /triplenegativo | "Cáncer de Mama Triple Negativo en Chile: Desafíos y acceso" | ~59 chars | Óptimo ✓ |
| /cancerdemamaysubtipos/her2positivo | "Cáncer de Mama HER2 Positivo: Avances y cobertura en Chile" | ~59 chars | Óptimo ✓ |
| /blog | "Blog del Observatorio del Cáncer" | ~33 chars | Corto pero aceptable |
| /publicaciones | "Análisis y estudios sobre cáncer en Chile" | ~42 chars | Bueno ✓ |
| /todo-sobre-cancer-1/cáncer-de-mama | "Cáncer de mama | Observatorio del Cáncer" | ~41 chars | Podría ser más descriptivo |
| /todo-sobre-cancer-1/i-am-a-title-01 | "Cáncer cervicouterino | Observatorio del Cáncer" | ~47 chars | URL no coincide con title — problema de slug |

**Nota**: El schema WebPage en `/cancerdemamaysubtipos` tiene `name: "Cáncer de Mama: Subtipos y Acceso en Chile | Observatorio del Cáncer"` (schema) vs title tag `"Cáncer de mama en Chile: subtipos, detección y cobertura"` — discrepancia entre schema name y title tag.

### 3.2 Meta Descriptions

| Página | Meta Description | Evaluación |
|---|---|---|
| Homepage | "El Observatorio del Cáncer promueve el acceso igualitario a tratamientos oncológicos en Chile mediante datos, investigación y políticas públicas basadas en evidencia." | ~167 chars — algo largo pero potente |
| /cancerdemamaysubtipos | "Información basada en evidencia sobre cáncer de mama en Chile: subtipos moleculares, exámenes de detección, coberturas GES, Ley Ricarte Soto y brechas de acceso" | ~161 chars — excelente |
| /triplenegativo | "Todo sobre el subtipo Triple Negativo: impacto social, agresividad y la urgencia de mejorar la cobertura y el acceso a terapias innovadoras en el sistema público." | ~163 chars — excelente |
| /her2positivo | "Análisis del subtipo HER2 positivo: importancia de las terapias dirigidas, acceso mediante la Ley Ricarte Soto y pronóstico actual de las pacientes." | ~148 chars — excelente |
| /blog | "Contenidos basados en evidencia sobre cáncer en Chile: análisis, contexto, calidad de vida, terapias y determinantes sociales de la enfermedad." | ~143 chars — excelente |
| /publicaciones | "Accede a informes, registros y estudios desarrollados por el Observatorio del Cáncer: evidencia, datos y análisis para comprender el cáncer en Chile" | ~149 chars — excelente |
| /todo-sobre-cancer-1/cáncer-de-mama | **AUSENTE** | Crítico — ~1.900 palabras sin meta description |
| /todo-sobre-cancer-1/i-am-a-title-01 | **AUSENTE** | Crítico |

### 3.3 Headings

**Homepage**:
- H1: **AUSENTE** — no hay H1 en ningún lugar del DOM
- H2 presentes (múltiples instancias duplicadas por renderizado Wix):
  - "Conocenos" / "Conócenos" / "CONÓCENOS" (variantes del mismo texto — error Wix)
  - "NUESTRAS INICIATIVAS"
  - "Han confiado en nuestro trabajo"
  - "Alianzas", "Estudios Clínicos", "Publicaciones"
- H3: "Investigación y Análisis", "Educación y Sensibilización", "Incidencia en Políticas Públicas", "Apoyo a la Comunidad"
- **Problema crítico**: Headings duplicados en DOM (mismo texto aparece 3 veces) — artefacto de Wix que puede confundir parsers de bots.

**Páginas de iniciativas**:
- `/triplenegativo`: H1 ausente. H2: "PRIMER INFORME CENSO #YOSOYTRIPLE", "MITOS QUE EXISTEN", etc.
- `/cancerdemamaysubtipos/her2positivo`: H1 ausente. H2: "PREGUNTAS FRECUENTES", etc.
- `/cancerdemamaysubtipos`: H1 con números estadísticos (99%, 1%, 2.3M...) — no son headings semánticos apropiados.

**Páginas "Todo sobre cáncer"**:
- `/todo-sobre-cancer-1/cáncer-de-mama`: H1 "Cáncer de mama" ✓, H2 bien estructurados ✓ — este patrón es correcto.
- `/todo-sobre-cancer-1/i-am-a-title-01` (cervicouterino): H1 "Cáncer cervicouterino" ✓, H2 estructurados ✓ — buen patrón.

**Heading order violations** (Lighthouse): Uso de H6 en footer y H4 fuera de jerarquía — violaciones de orden secuencial detectadas.

### 3.4 Internal Linking

La homepage tiene 25 enlaces internos únicos (sin contar duplicados por Wix render). Las páginas principales del menú son:
- Todo sobre cáncer, Nuestro ADN, Gobernanza, Memorias, Cáncer de mama, Atrévete (próstata), Usa Filtro (piel), Reconstrucción Mamaria, Esperanza Rosa, Conversaciones Impostergables, Publicaciones, Blog, Prensa, Revista, Podcast, Consultoría, Contacto.

**Problemas detectados**:
- Múltiples enlaces con texto vacío (`` iconos/imágenes sin texto alternativo en anchor) — Lighthouse: "Links do not have a discernible name"
- Algunos CTAs usan texto genérico: "Haz clic aquí", "Ver más aquí", "Conoce más sobre esta iniciativa" — texto de anchor no descriptivo para SEO.
- La sección "Todo sobre cáncer" (14 páginas de contenido profundo) **no aparece en el menú principal** — solo accesible desde `/todo-sobre-cancer`. Reduce la señal de autoridad interna hacia estas páginas.
- "Gobernanza" en footer enlaza a `/` (homepage) en lugar de `/gobernanza` — error de enlace.

---

## 4. Schema / Structured Data (10%)

### 4.1 Implementación actual

**Schema presente en TODAS las páginas**:
```json
{
  "@type": "NGO",
  "@id": "https://www.observatoriodelcancer.cl/#organization",
  "name": "Observatorio del Cáncer",
  "url": "https://www.observatoriodelcancer.cl/",
  "logo": { "@type": "ImageObject", "url": "..." },
  "areaServed": { "@type": "Country", "name": "Chile" },
  "knowsAbout": ["Cáncer en Chile", "Prevención del cáncer", ...],
  "sameAs": [Instagram, LinkedIn, Facebook, YouTube]
}
```

**Schema por página** (implementado en páginas de iniciativas, no en todo-sobre-cancer):
```json
{
  "@type": "WebPage",
  "@id": "...#webpage",
  "name": "...",
  "description": "...",
  "isPartOf": {"@id": ".../#website"},
  "publisher": {"@id": ".../#organization"},
  "about": [{"@type": "Thing", "name": "..."}, ...]
}
```

**Schema en homepage**:
```json
{"@type": "WebSite", "name": "Observatorio del Cáncer", "url": "..."}
```

### 4.2 Lo que falta (alto impacto)

| Schema faltante | Páginas afectadas | Impacto |
|---|---|---|
| `BlogPosting` con `author`, `datePublished`, `dateModified`, `headline` | 127 artículos de blog | Rich results, AI Overviews, E-E-A-T |
| `Article` o `MedicalWebPage` | 14 páginas "Todo sobre cáncer" | Autoridad médica, AI citations |
| `FAQPage` | /cancerdemamaysubtipos/her2positivo (tiene sección FAQ) | Featured snippets |
| `Event` | /ceremoniaanual2025, /conversaciones-impostergables-2025 | Rich results de eventos |
| `Person` + `author` | Equipo listado en /gobernanza | E-E-A-T authorship |
| `Report` o `ScholarlyArticle` | /publicaciones (informes descargables) | Citabilidad y autoridad |
| `SiteLinksSearchBox` / `SearchAction` | Homepage | Sitelinks search en SERP |
| `BreadcrumbList` | Páginas de subnivel (her2positivo, todo-sobre-cancer-1/*) | Breadcrumbs en SERP |

### 4.3 Problemas de validación

- Páginas `/todo-sobre-cancer-1/cáncer-de-mama` tienen 3 scripts JSON-LD: el NGO global, y 2 objetos vacíos `{}` — schemas inválidos que podrían generar errores en Google Rich Results Test.
- La discrepancia entre `WebPage.name` en schema y el `<title>` tag en varias páginas puede generar advertencias.

---

## 5. Performance / Core Web Vitals (10%)

### 5.1 Métricas medidas (Chrome DevTools, red local, desktop)

| Métrica | Valor | Referencia |
|---|---|---|
| TTFB | 105ms | Excelente (<200ms) ✓ |
| First Paint | 216ms | Excelente ✓ |
| First Contentful Paint | 216ms | Excelente ✓ |
| DOM Content Loaded | 211ms | Excelente ✓ |
| Load Complete | 579ms | Excelente ✓ |
| Total Transfer Size (página) | 227KB | Razonable |
| Total Transfer Size (todos recursos) | 272KB | Aceptable |
| Decoded Body Size | 1.55MB | Wix genera mucho HTML |
| Recursos totales | 164 | Alto — 103 scripts JS |

**Contexto importante**: Estas métricas se midieron en red local rápida (MacOS, Chrome desktop). En condiciones móviles reales (3G/4G, Chile), los valores serán significativamente peores dado el volumen de scripts.

### 5.2 Lighthouse Scores (desktop, simulado)

| Categoría | Score |
|---|---|
| Accessibility | 95/100 |
| Best Practices | 73/100 |
| SEO | 100/100 |
| Performance | No medido directamente* |

*Lighthouse fue ejecutado sin la categoría "performance" en los runs completados (limitación del entorno). Sin embargo, la arquitectura Wix con 103 JS requests es un factor de riesgo conocido para performance en mobile.

### 5.3 Problemas de performance detectados

**Best Practices (73/100) — Issues**:
1. **8 cookies de terceros** (Microsoft Clarity × 3, Google Tag Manager, Sentry, CrazyEgg, Metricool) — regulación y privacidad.
2. **Errores de consola**: `"members area viewer has no routes"` (Wix interno) y `"suspense rendered fallback for ExpandableMenu"` — errores JS en runtime.
3. **Inspector Issues**: Cookie compliance violations.

**Recursos de terceros detectados**:
| Dominio | Requests | Propósito |
|---|---|---|
| static.parastorage.com | 99 | CDN Wix (JS/CSS) |
| www.googletagmanager.com | 2 | Analytics |
| www.clarity.ms / scripts.clarity.ms | 3 | Microsoft Clarity heatmaps |
| script.crazyegg.com | 2 | CrazyEgg heatmaps |
| browser.sentry-cdn.com | 1 | Error monitoring |
| tracker.metricool.com | 1 | Metricool social analytics |
| panorama.wixapps.net | 4 | Wix apps |

**Observación**: El sitio tiene **dos herramientas de heatmaps activas simultáneamente** (Clarity + CrazyEgg). Esto es redundante y suma peso de tracking scripts innecesariamente. Se recomienda elegir una.

### 5.4 Core Web Vitals en campo (estimado)

Sin datos de Google Search Console disponibles directamente en este audit, los CWV de campo se estiman basados en la arquitectura:
- **LCP**: Probable degradación en mobile por carga de imágenes desde Wix CDN (wixstatic.com) y volumen de JS
- **CLS**: Wix suele tener CLS moderado por carga asíncrona de componentes — los errores de "suspense fallback" son señal de esto
- **INP**: 103 scripts JS en homepage son un riesgo para INP (Interaction to Next Paint) en dispositivos de gama media

---

## 6. Images (5%)

### 6.1 Cobertura de alt text

| Página | Total imgs | Sin alt text | % Sin alt |
|---|---|---|---|
| Homepage | 31 | 7 | 22.6% |
| /cancerdemamaysubtipos | 19 | 0 | 0% ✓ |
| /triplenegativo | 51 | 0 | 0% ✓ |
| /cancerdemamaysubtipos/her2positivo | ~20 | 0 | 0% ✓ |
| /todo-sobre-cancer-1/cáncer-de-mama | ~15 | 6 | ~40% |
| /blog | Variable | Desconocido | — |

**7 imágenes sin alt text en homepage** — confirmado por OnPage audit (flag: `no_image_alt: 1`).

### 6.2 Formatos y CDN

- Imágenes servidas desde `static.wixstatic.com` — CDN global de Wix con buena distribución
- Wix soporta conversión automática a WebP/AVIF para navegadores compatibles
- Lighthouse no detectó problemas de aspect ratio (`image-aspect-ratio: score=1`) ✓
- Tamaño responsive correcto (`image-size-responsive: score=1`) ✓

### 6.3 Recomendaciones

- Corregir las 7 imágenes sin alt en homepage (probablemente logos de alianzas/partners y elementos decorativos)
- Verificar las 6 imágenes sin alt en `/todo-sobre-cancer-1/cáncer-de-mama`
- Para imágenes informativas (infografías, estadísticas), asegurar alt text descriptivo del contenido numérico

---

## 7. SERP Presence

### 7.1 Visibilidad orgánica (DataForSEO Labs, Chile)

| Métrica | Valor |
|---|---|
| Keywords totales rankeando | 43 (en top 100, Chile) |
| ETV estimado (tráfico) | ~612 visitas/mes |
| Posición 1 | 0 keywords |
| Posición 2-3 | 1 keyword |
| Posición 4-10 | 6 keywords |
| Posición 11-20 | 8 keywords |
| Keywords en ascenso | 21 |
| Keywords en descenso | 3 |
| Keywords perdidas (recientes) | 12 |

**Nota**: El volumen de 43 keywords en Chile es bajo para un sitio con 31 páginas + 127 artículos de blog. Indica que el potencial orgánico está muy sub-aprovechado, especialmente en la sección "Todo sobre cáncer" y el blog.

### 7.2 Rankings clave verificados

| Keyword | Posición | URL rankeando | SV estimado |
|---|---|---|---|
| observatorio del cancer chile | #1 | / | — |
| cancer de mama chile | #9 | /cancerdemamaysubtipos | Alto |
| triple negativo cancer de mama | #6 | /triplenegativo | Medio |
| cancer testicular sintomas | No rankea | — | Medio (sitio tiene /cancertesticular) |

### 7.3 SERP features presentes

- **"cancer de mama chile"**: AI Overview presente, People Also Ask presente → el sitio rankea #9 en posiciones orgánicas pero NO aparece en AI Overview ni PAA, a pesar de tener contenido relevante.
- **"triple negativo cancer de mama"**: AI Overview presente, PAA presente → el sitio rankea #6 pero no en AI Overview.
- **"observatorio del cancer chile"**: Sitelinks presentes (6 subpáginas) ✓ — buena señal de autoridad de marca.

### 7.4 Competidores en SERP

Para "cancer de mama chile", los principales competidores son:
1. superdesalud.gob.cl (gobierno)
2. ucchristus.cl (clínica privada)
3. falp.org (FALP — Fundación Arturo López Pérez)
4. scielo.cl (publicaciones científicas)
5. diprece.minsal.cl (MINSAL)

Para "triple negativo cancer de mama":
1. minsal.cl, bcrf.org, breastcancer.org, elsevier.es, cancer.org

El sitio compite directamente con fuentes institucionales y médicas de alto DA. La falta de schema médico específico (`MedicalWebPage`) es una desventaja frente a sitios como Mayo Clinic o Cancer.org que dominan con este schema.

---

## 8. AI Search Readiness (5%)

### 8.1 Señales de citabilidad

**Fortalezas**:
- Contenido basado en evidencia con referencias a organismos reconocidos (OMS, GES, Ley Ricarte Soto, MINSAL)
- Datos estadísticos específicos y actualizados (importantes para AI citations)
- Fundación reconocida con presencia institucional (aparece en oncored.org, etc.)
- WebSite y Organization schema implementados
- Contenido en español para mercado chileno — menor competencia en AI Overviews vs inglés

**Debilidades**:
- Sin `Article` o `MedicalWebPage` schema — los AI Overviews priorizan páginas con estos schemas para contenido médico
- Sin `author` explícito marcado en schema — las citas de AI valoran la atribución de autoría
- Sin `datePublished` / `dateModified` en schema de artículos — los LLMs usan estas fechas para evaluar freshness
- Contenido del blog (127 artículos) no tiene schema que lo marque como contenido citable
- Sin `citedBy` o referencias externas marcadas en schema

### 8.2 Estructura del contenido para AI

- Las páginas "Todo sobre cáncer" tienen buena estructura con H1 + H2 semánticos — favorable para extracción de IA
- Las preguntas frecuentes en `/her2positivo` podrían marcarse con `FAQPage` schema para aparecer en PAA y AI Overviews
- El blog usa URLs con tildes (ej. `/todo-sobre-cancer-1/cáncer-de-mama`) — aunque válidas, pueden causar problemas en algunos contextos de normalización de URLs

---

## 9. Plan de Acción Priorizado

### CRÍTICO — Implementar esta semana

| # | Acción | Páginas | Esfuerzo | Impacto esperado |
|---|---|---|---|---|
| C1 | Agregar H1 a homepage y páginas de iniciativas sin H1 (/triplenegativo, /her2positivo) | 3+ páginas | Bajo (Wix editor) | Rankings, CTR |
| C2 | Agregar meta description a todas las páginas de "Todo sobre cáncer" (14 páginas sin descripción) | 14 páginas | Medio | CTR en SERP |
| C3 | Corregir 4 slugs placeholder (`i-am-a-title-0X`) con redirección 301 a slug semántico | 4 páginas | Bajo-Medio | Indexación, rankings |
| C4 | Agregar og:image a todas las páginas | 31+ páginas | Medio (Wix Social Share settings) | CTR social, compartibilidad |
| C5 | Corregir enlace "Gobernanza" en footer (apunta a / en lugar de /gobernanza) | Footer global | Bajo | Link juice, UX |

### ALTO — Implementar este mes

| # | Acción | Páginas | Esfuerzo | Impacto esperado |
|---|---|---|---|---|
| A1 | Implementar `BlogPosting` schema con `author`, `datePublished`, `headline`, `image` en todos los artículos | 127 artículos | Alto (Wix Blog settings o custom) | Rich results, AI citations, E-E-A-T |
| A2 | Implementar `MedicalWebPage` o `Article` schema en páginas "Todo sobre cáncer" | 14 páginas | Medio-Alto | Autoridad médica, AI Overviews |
| A3 | Corregir 7 imágenes sin alt text en homepage | Homepage | Bajo | Accesibilidad, SEO imagen |
| A4 | Revisar y eliminar sitemaps de tienda vacíos (store-products, store-categories) si no hay tienda activa | sitemap.xml | Bajo | Crawl budget |
| A5 | Acortar title de homepage a máximo 60 caracteres (actualmente 82) | Homepage | Bajo | SERP display |
| A6 | Reemplazar CTAs genéricos ("Haz clic aquí", "Ver más aquí") con texto descriptivo | Homepage, varias | Medio | Accesibilidad, anchor text |
| A7 | Agregar `Person` schema al equipo en /gobernanza con campos `jobTitle`, `knowsAbout` | /gobernanza | Medio | E-E-A-T authorship |

### MEDIO — Implementar en 1-3 meses

| # | Acción | Páginas | Esfuerzo | Impacto esperado |
|---|---|---|---|---|
| M1 | Implementar `FAQPage` schema en páginas con sección de preguntas frecuentes (/her2positivo, /cancertesticular, etc.) | 3-5 páginas | Medio | Featured snippets, PAA |
| M2 | Agregar `Event` schema a páginas de eventos y ceremonias | 3-4 páginas | Bajo | Rich results de eventos |
| M3 | Implementar `SiteLinksSearchBox` / `SearchAction` en homepage | Homepage | Bajo | Branded SERP enhancement |
| M4 | Agregar `BreadcrumbList` schema en páginas de subnivel | /cancerdemamaysubtipos/*, /todo-sobre-cancer-1/* | Medio | Breadcrumbs en SERP |
| M5 | Corregir heading order (H6 en footer, H4 fuera de jerarquía) | Global (Wix theme) | Medio | Accesibilidad, estructura semántica |
| M6 | Consolidar herramientas de heatmap (elegir Clarity O CrazyEgg, no ambas) | Global | Bajo | Performance, privacidad |
| M7 | Ampliar contenido de homepage a 800-1.000 palabras con secciones indexables | Homepage | Medio | Rankings, autoridad |
| M8 | Desarrollar contenido para `/cancertesticular` para rankear "cancer testicular sintomas" (SV medio, sin competencia del sitio) | /cancertesticular | Alto | Nuevo tráfico orgánico |
| M9 | Agregar `hreflang="es-CL"` self-referencing en todas las páginas | Global | Bajo | Señalización geográfica |

### BAJO — Backlog / Nice to have

| # | Acción | Notas |
|---|---|---|
| L1 | Renovar certificado SSL antes de mayo 2026 | Wix lo hace automáticamente, verificar |
| L2 | Añadir `Report` / `ScholarlyArticle` schema a publicaciones descargables | Para citabilidad académica |
| L3 | Implementar campo `telephone` y `address` en NGO schema | Para NAP consistency local |
| L4 | Crear página 404 personalizada con enlaces de navegación | UX y bounce rate |
| L5 | Corregir errores de consola JS de Wix (members area routes, ExpandableMenu suspense) | Reducir Best Practices issues |
| L6 | Auditar cookies de terceros para cumplimiento Ley 21.719 (Chile) | Legal compliance |

---

## Apéndice: Datos de referencia

### Sitemaps — resumen
- Total páginas indexadas: ~172+ (31 pages + 127 blog posts + 14 todo-sobre-cancer + otros)
- Última actualización: 2026-03-16

### OnPage Score (DataForSEO)
- Score: **88.66 / 100** (basado en crawl de 1 página — homepage)
- Flags activados: `title_too_long`, `large_page_size`, `no_h1_tag`, `low_content_rate`, `no_image_alt`, `no_image_title`, `low_readability_rate`, `has_render_blocking_resources`

### Domain Rank (DataForSEO Labs, Chile, ES)
- Keywords top 100: 43
- ETV: ~612 visitas/mes estimadas
- Tendencia: 21 keywords subiendo, 3 bajando, 12 perdidas recientemente

### Recursos Homepage
- 164 requests totales
- 103 scripts JS
- Transfer size: 272KB / Decoded body: 1.55MB
- 9 dominios de terceros activos

---
*Audit generado el 2026-03-17 con herramientas: Chrome DevTools MCP (Lighthouse, JS evaluation), DataForSEO Labs, DataForSEO OnPage, DataForSEO SERP, WebFetch + DOM rendering analysis.*
