# Auditoría SEO: observatoriodelcancer.cl
**Fecha**: 2026-03-16 | **Tipo**: Site Audit | **Objetivo**: Informacional / Autoridad temática cáncer
**Nota**: Métricas on-page estimadas — MCP onpage_pages no disponible en este entorno. Datos basados en GSC + DataForSEO Labs.

---

## SEO Health Index: 52/100 — Aceptable (bajo)

| Categoría | Score | Problemas detectados |
|---|---|---|
| Crawlabilidad e indexación | 18/25 | Sin dato técnico directo (MCP no disponible) |
| Fundamentos técnicos | 10/20 | Canibalización detectada en múltiples keywords |
| On-Page | 12/20 | URLs con caracteres especiales (%C3%B3n), títulos no optimizados en páginas clave |
| Calidad de contenido | 8/20 | Tráfico muy concentrado en pocas páginas, mayoría en pos. 11-100 |
| Links internos y autoridad | 4/15 | Sin datos de backlinks (suscripción no activa) |

**Bandas**: Excelente (90-100) · Bueno (75-89) · Aceptable (60-74) · **Bajo (40-59)** · Crítico (<40)

---

## Visión general del sitio

| Métrica | Valor |
|---|---|
| Keywords rankeadas (Chile) | 43 |
| Tráfico orgánico estimado (ETV) | 612 visitas/mes |
| Keywords pos. 1-3 | 1 (birads, pos.7 — vol. 2.400) |
| Keywords pos. 4-10 | 6 |
| Keywords pos. 11-20 | 8 |
| Keywords pos. 21-100 | 28 |
| Keywords perdidas recientemente | 12 |
| Keywords en ascenso | 21 |
| Páginas en GSC (top 20 por tráfico) | 20 |
| Tráfico brand ("observatorio del cancer") | ~113 clicks/90 días — 58% del total |

**El sitio vive del tráfico de marca.** El tráfico no-brand es marginal — 3 clicks para "cancer de mama triple negativo" con 1.336 impresiones indica un CTR de 0.2% en una keyword de volumen real.

---

## Hallazgos por prioridad

### Críticos

| Problema | Dónde | Impacto | Cómo corregir |
|---|---|---|---|
| **Canibalización en /triplenegativo** | `/triplenegativo` rankea en pos. 5, 6, 8, 8 y 9 con 4 keywords distintas de la misma familia ("cancer de mama triple negativo", "cáncer triple negativo", etc.) — todas apuntando a la misma URL | Confusión de señales en Google, CTR fragmentado, difícil llegar a pos. 1-3 | Consolidar en una sola página con keyword principal "cáncer de mama triple negativo" y crear redirects o links internos desde variantes |
| **0 keywords en pos. 1** | Todo el dominio | Sin posición 1 = sin dominio de ningún tema | Priorizar las 3 keywords más cercanas a pos.1 y optimizarlas intensamente |
| **Tráfico no-brand casi nulo** | Global | 85% del tráfico es búsqueda de marca — sin brand, el sitio desaparece | Crear contenido orientado a keywords informacionales con volumen real |

### Importantes

| Problema | Dónde | Impacto | Cómo corregir |
|---|---|---|---|
| **URLs con caracteres especiales en español** | `/post/actualizaci%C3%B3n-plan-nacional...`, `/post/mamograf%C3%ADas-sin-orden...` | Dificulta el link building y el compartir manual | Usar slugs en inglés o sin tildes: `/plan-nacional-cancer-2022-2027` |
| **Página /triplenegativo en pos. 8-9 para keyword de 3.600 búsquedas/mes** | `/triplenegativo` | Con 3.600 búsquedas y solo 46 clicks en 90 días (CTR 0.4%), hay mucho tráfico perdido | Optimizar title, meta description y agregar FAQ para capturar featured snippet |
| **Keyword "birads" en pos. 7 con 2.400 búsquedas** | `/post/claves-para-entender-las-categor%C3%ADas-bi-rads-en-c%C3%A1ncer-de-mama` | Solo 9 clicks con 4.140 impresiones (CTR 0.2%) | Reescribir title tag — probablemente no está incluyendo "BI-RADS" en las primeras palabras; mejorar meta description |
| **3 páginas compitiendo por "her2 positivo"** | `/cancerdemamaysubtipos/her2positivo`, `/her2positivo-1`, `/cancerdemamaysubtipos` | Canibalización — Google no sabe cuál posicionar | Elegir una URL canónica, redirigir o consolidar las otras dos |

### Quick Wins

| Problema | Dónde | Esfuerzo | Cómo corregir |
|---|---|---|---|
| **"mamografia sin orden" en pos. 17-20** | `/post/mamografías-sin-orden-médica-ley-21-551-entró-en-vigencia` | Bajo | Optimizar H1 y title con la keyword exacta "mamografía sin orden médica"; agregar respuesta directa en primer párrafo |
| **"plan nacional del cancer" en pos. 11** | `/post/actualización-plan-nacional-de-cáncer-2022-2027` | Bajo | Actualizar contenido con datos 2025-2026 si los hay; mejorar title para incluir "Chile" |
| **"her2 positivo se cura" en pos. 4 con 103 búsquedas** | `/cancerdemamaysubtipos/her2positivo` | Bajo | Crear sección específica con respuesta directa a la pregunta — candidato a featured snippet |

---

## Detección de canibalización

| Cluster | URLs en conflicto | Keyword disputada | Acción |
|---|---|---|---|
| HER2 | `/cancerdemamaysubtipos/her2positivo` + `/her2positivo-1` + `/cancerdemamaysubtipos` | "her2 positivo", "her2 positivo se cura" | Consolidar en `/cancerdemamaysubtipos/her2positivo`, redirigir `/her2positivo-1` |
| Triple negativo | `/triplenegativo` (múltiples variantes keyword) | "cancer triple negativo", "cáncer de mama triple negativo" | No es canibalización de URLs, sino de keywords — una sola URL para todas las variantes, bien hecho |
| BI-RADS | `/post/claves-para-entender-las-categorías-bi-rads...` + mencionado en otras páginas | "birads 2", "birads 3", "bi-rads 2 que significa" | Crear una página pilar de BI-RADS con links a categorías específicas |

---

## Ranking de páginas por tráfico GSC (90 días)

| # | Página | Clicks | Impresiones | CTR | Pos. media |
|---|---|---|---|---|---|
| 1 | `/` (homepage) | 193 | 1.527 | 12.6% | 10.4 |
| 2 | `/reconstruccion-mamaria` | 64 | 4.470 | 1.4% | 7.5 |
| 3 | `/triplenegativo` | 46 | 11.408 | 0.4% | 9.1 |
| 4 | `/revista` | 27 | 294 | 9.2% | 2.7 |
| 5 | `/post/actualización-plan-nacional-cáncer-2022-2027` | 25 | 1.515 | 1.7% | 7.0 |
| 6 | `/estudios-clinicos` | 18 | 801 | 2.2% | 9.1 |
| 7 | `/post/pembrolizumab-sistema-público` | 15 | 578 | 2.6% | 7.1 |
| 8 | `/cancerdemamaysubtipos/her2positivo` | 14 | 2.914 | 0.5% | 4.8 |
| 9 | `/post/mamografías-sin-orden-médica-ley-21-551` | 14 | 1.751 | 0.8% | 5.2 |
| 10 | `/cancerdemamaysubtipos` | 10 | 1.291 | 0.8% | 8.2 |

**Páginas con CTR bajo vs impresiones altas = mayor oportunidad inmediata:**
- `/triplenegativo`: 11.408 impresiones, CTR 0.4% → mejorar title/meta
- `/reconstruccion-mamaria`: 4.470 impresiones, CTR 1.4% → mejorar title/meta
- `/cancerdemamaysubtipos/her2positivo`: 2.914 impresiones, CTR 0.5% → mejorar title/meta

---

## Insights de mejora

- **Oportunidad principal**: `/triplenegativo` tiene 11.408 impresiones/trimestre con CTR de 0.4% — mejorar el title tag y meta description podría triplicar el tráfico sin escribir una línea nueva de contenido.
- **Brecha vs competidores**: El sitio no tiene posición 1 en ninguna keyword. Los competidores que sí rankean primero en términos como "cáncer de mama triple negativo" probablemente tienen más palabras, más secciones de FAQ y más links internos.
- **Riesgo ignorado**: Canibalización en el cluster HER2 — tres URLs compitiendo por las mismas keywords impide que ninguna llegue a posiciones 1-3.
- **Palanca de crecimiento**: El contenido informacional del sitio ya tiene impresiones reales (11K+/trimestre en triple negativo) pero CTR mínimo. Optimizar los meta datos de las top 5 páginas es el trabajo de una tarde con potencial de doblar el tráfico orgánico no-brand.
- **Siguiente contenido sugerido**: Página pilar "BI-RADS: guía completa" — el sitio ya rankea para "birads", "birads 2", "birads 3", "bi-rads 2 que significa" (vol. total ~5.000+/mes) pero sin una página dedicada que consolide todo ese tráfico.

---

## Plan de acción

| Acción | Impacto est. | Esfuerzo | Prioridad |
|---|---|---|---|
| Optimizar title + meta de `/triplenegativo` | +50-150 clicks/mes | 1h | 🔴 Inmediata |
| Optimizar title + meta de `/reconstruccion-mamaria` | +30-80 clicks/mes | 1h | 🔴 Inmediata |
| Optimizar title + meta de `/cancerdemamaysubtipos/her2positivo` | +20-60 clicks/mes | 1h | 🔴 Inmediata |
| Redirigir `/her2positivo-1` → `/cancerdemamaysubtipos/her2positivo` | Consolidar autoridad HER2 | 30min | 🟠 Esta semana |
| Crear página pilar BI-RADS | +200-500 clicks/mes a largo plazo | 1 semana | 🟠 Este mes |
| Actualizar `/post/plan-nacional-cancer-2022-2027` con datos 2025 | +10-30 clicks/mes | 2h | 🟡 Próximo mes |
| Cambiar URLs de posts a slugs sin caracteres especiales | Mejora técnica acumulativa | Medio | 🟡 Próximo mes |

> Siguiente paso sugerido: `/webmometro-seo audit https://www.observatoriodelcancer.cl/triplenegativo` para un análisis profundo de la página con más impresiones.
