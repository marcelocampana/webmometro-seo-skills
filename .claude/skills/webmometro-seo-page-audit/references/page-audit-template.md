# Auditoría de Página — {slug}
**Dominio**: {dominio} | **URL**: {url}
**Fecha**: {fecha} | **Última actualización**: {fecha}

---

## Resumen ejecutivo

| Categoría | Peso | Score | Puntos |
|---|---|---|---|
| On-Page SEO | 25% | {score}/100 | {puntos} |
| Contenido y E-E-A-T | 20% | {score}/100 | {puntos} |
| Technical SEO | 15% | {score}/100 | {puntos} |
| Schema / Datos estructurados | 10% | {score}/100 | {puntos} |
| Backlinks | 10% | {score}/100 | {puntos} |
| Performance (CWV) | 10% | {score}/100 | {puntos} |
| Visibilidad en AI Search | 5% | {score}/100 | {puntos} |
| Interlinks | 5% | {score}/100 | {puntos} |
| **TOTAL** | | | **{total}/100 — {estado según rango}** |

| Rango | Estado |
|---|---|
| 85–100 | 🟢 Excelente |
| 70–84 | 🟡 Bueno |
| 50–69 | 🟠 Necesita mejoras |
| 0–49 | 🔴 Crítico |

**Keyword principal**: {keyword} | **Posición actual**: {posición} | **CTR actual**: {ctr}% (benchmark pos {pos}: ~{ctr_bench}%)

**Top 3 hallazgos**:
1. {hallazgo 1}
2. {hallazgo 2}
3. {hallazgo 3}

---

## Keywords y datos GSC

**Últimos 90 días para esta URL**:

| Keyword | Clicks | Impresiones | CTR | Posición | CTR benchmark | Gap |
|---|---|---|---|---|---|---|
| {keyword} | {N} | {N} | {N}% | {N} | ~{N}% | {+/-N pp} |

*(Top 5 keywords por impresiones)*

---

## Plan de acción

### 🔴 Crítico

<!-- Bloquea indexación, canonical incorrecto, noindex activo, o impacto muy alto. Fix inmediato. -->

- [ ] {acción concisa} → **+{X} clicks/mes** *(esfuerzo: {X}h)*

### 🟠 Alto impacto

<!-- Impacto >50 clicks/mes con esfuerzo bajo-medio. Esta semana. -->

- [ ] {acción concisa} → **+{X} clicks/mes** *(esfuerzo: {X}h)*

### 🟡 Backlog

<!-- Impacto <10 clicks/mes o mejora de calidad. -->

- [ ] {acción concisa} → {impacto cualitativo} *(esfuerzo: {X}h)*

---

## 1. On-Page SEO

| Elemento | Valor actual | Evaluación |
|---|---|---|
| Title tag | "{texto}" ({N} chars) | ✅ / ⚠️ / ❌ — {comentario} |
| Meta description | "{texto}" ({N} chars) | ✅ / ⚠️ / ❌ — {comentario} |
| H1 | "{texto}" (¿{N} H1?) | ✅ / ⚠️ / ❌ — {comentario} |
| Canonical | {url canonical} | ✅ coincide / ❌ {problema} |
| Robots meta | {index/noindex, follow/nofollow} | ✅ / ❌ |

**Jerarquía de headings**:
```
H1: {texto}
  H2: {texto}
    H3: {texto}
  H2: {texto}
```

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {elemento} | {dato concreto: texto actual, longitud, gap} | Critical / High / Medium / Low |

---

## 2. Contenido y E-E-A-T

| Señal | Estado | Detalle |
|---|---|---|
| Word count | ~{N} palabras | ✅ suficiente / ⚠️ corto / ❌ thin |
| Autoría | ✅ / ❌ | {nombre mencionado o ausente} |
| Credenciales | ✅ / ❌ | {qué aparece o qué falta} |
| Fecha publicación/actualización | ✅ / ❌ | {fecha visible o ausente} |
| Fuentes citadas | ✅ / ❌ / N/A | {cuántas, qué tipo} |
| CTA | ✅ / ❌ | {texto del CTA o ausente} |

**Comportamiento de usuario (Clarity)** *(omitir si no hay datos)*:

| Métrica | Valor | Interpretación |
|---|---|---|
| Quick backs | {N}% | ✅ <20% / ⚠️ 20–40% / ❌ >40% — {intención satisfecha o no} |
| Scroll depth promedio | {N}% | ✅ >70% / ⚠️ 50–70% / ❌ <50% — {estructura o relevancia} |
| Rage clicks | {N sesiones} | ✅ ninguno / ⚠️ / ❌ — zona: {descripción} |
| Dead clicks | {N sesiones} | ✅ ninguno / ⚠️ / ❌ — elemento: {descripción} |
| Duración promedio (sesiones orgánicas) | {Xm Xs} | ✅ / ⚠️ / ❌ — {engagement con el contenido} |

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {señal E-E-A-T o Clarity} | {qué falta o qué está mal} | High / Medium / Low |

---

## 3. Schema y datos estructurados

| Schema detectado | Campos presentes | Campos faltantes | Prioridad |
|---|---|---|---|
| {tipo o "ninguno"} | {campos} | {campos recomendados} | High / Medium / Low |

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {schema faltante o con error} | {por qué importa, qué campos agregar} | High / Medium |

---

## 4. Performance y Core Web Vitals

| Métrica | Mobile | Desktop | Benchmark |
|---|---|---|---|
| Performance score | {N} | {N} | ≥90 |
| LCP | {Xs} | {Xs} | ≤2.5s |
| CLS | {N} | {N} | ≤0.1 |
| INP | {Xms} | {Xms} | ≤200ms |
| FCP | {Xs} | {Xs} | ≤1.8s |
| TTFB | {Xms} | {Xms} | ≤800ms |

**Top oportunidad PageSpeed**: {descripción del issue principal}

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {métrica o flag} | {valor medido vs benchmark} | High / Medium / Low |

---

## 5. Imágenes

*(Sección cualitativa — no contribuye al score numérico)*

| Métrica | Valor |
|---|---|
| Total imágenes | {N} |
| Sin alt text | {N} ({%}) |
| Formatos detectados | {jpg/png/webp/etc.} |

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {issue} | {cantidad, % afectado, formato} | High / Medium / Low |

---

## 6. Backlinks

| Métrica | Valor |
|---|---|
| Dominios únicos referentes | {N} |
| Total backlinks | {N} |

**Top 5 backlinks por autoridad del referente**:

| Dominio referente | URL de origen | Anchor text | Spam score |
|---|---|---|---|
| {dominio} | {url} | {anchor} | {N}% |

**Distribución de anchor text**:

| Tipo | Cantidad | % |
|---|---|---|
| Keyword objetivo | {N} | {%} |
| Variantes de keyword | {N} | {%} |
| Marca | {N} | {%} |
| Genérico (click aquí, ver más) | {N} | {%} |
| URL desnuda | {N} | {%} |

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {issue o fortaleza} | {detalle} | High / Medium / Low |

---

## 7. Interlinks

**Links internos entrantes** (páginas del sitio que enlazan a esta URL):

| Métrica | Valor |
|---|---|
| Páginas internas que enlazan aquí | {N} |
| Anchor texts distintos usados | {N} |

**Links internos salientes** (desde esta página hacia otras del sitio):

| Métrica | Valor |
|---|---|
| Links internos salientes | {N} |
| Páginas destino únicas | {N} |

**Oportunidades de interlinks** (páginas con tráfico que deberían enlazar aquí):

| Página | Clicks/90d | Relevancia temática | Acción |
|---|---|---|---|
| {url} | {N} | {por qué es relevante} | Agregar link con anchor "{keyword}" |

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {issue} | {detalle} | High / Medium / Low |

---

## 8. Canibalización

| Keyword | Esta URL | Otras URLs del sitio | Diagnóstico |
|---|---|---|---|
| {keyword} | pos {N} | {url} pos {N} | {canibalización real / variante normal / sin problema} |

**Acción recomendada**: {consolidar en {url} / agregar canonical / redirect / ninguna}

---

## 9. Visibilidad en AI Search

**Keyword analizada**: {keyword} (posición orgánica del dominio: {N})

| SERP Feature | Presente | ¿Dominio aparece? |
|---|---|---|
| AI Overview | ✅ / ❌ | ✅ / ❌ |
| Featured Snippet | ✅ / ❌ | ✅ / ❌ |
| PAA | ✅ / ❌ | ✅ / ❌ |
| Local Pack | ✅ / ❌ | ✅ / ❌ |
| Video | ✅ / ❌ | N/A |

**Top 3 competidores orgánicos vs este dominio**:

| Competidor | Pos | Qué tienen de diferente |
|---|---|---|
| {dominio} | {N} | {schema, contenido, estructura} |

**Hallazgos**:

| Hallazgo | Detalle | Prioridad |
|---|---|---|
| {keyword — feature} | {por qué aparecen competidores / qué falta} | Critical / High / Medium |
