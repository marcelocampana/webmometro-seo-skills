---
name: webmometro-seo-benchmarks
description: |
  Calcula rangos objetivo de word count, headings, párrafos e imágenes basados en competidores reales del SERP.
  Genera los targets que usa el Content Score para evaluar un contenido.
  Triggers: "benchmarks", "rangos objetivo", "cuántas palabras necesito", "targets seo"
argument-hint: "[keyword]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-benchmarks — Cálculo de Benchmarks

Calcula los rangos objetivo para un contenido basándose en las métricas reales de los competidores del SERP.

## Invocación

```
/webmometro-seo-benchmarks [keyword]
```

Requiere `reports/{keyword-slug}/02-competitors.md` previo.

## Flujo de ejecución

1. Lee `reports/{keyword-slug}/02-competitors.md`
2. Para cada métrica calcula:
   - **Rango objetivo**: [P25 − 10%, P75 + 10%] → zona donde estar es competitivo
   - **Mínimo aceptable**: P25 − 20%
   - **Objetivo ambicioso**: P75 + 20%
3. Método leave-one-out para Avg y Top (evita circularidad):
   - Para cada competidor c_i, calcula targets usando el resto (c_j, j≠i)
   - Aplica esos targets para scorear c_i
   - avg_score = mean de todos los competitor scores
   - top_score = max de todos los competitor scores
4. Guarda benchmarks en `reports/{keyword-slug}/03-benchmarks.json`

## Métricas calculadas

| Métrica | P25 | Promedio | P75 | Rango objetivo |
|---|---|---|---|---|
| Word count | | | | |
| Headings H2 | | | | |
| Párrafos | | | | |
| Imágenes | | | | |
| Links internos | | | | |
| Links externos | | | | |

## Output JSON

```json
{
  "keyword": "{keyword}",
  "snapshot_id": "{snapshot_id}",
  "date": "{date}",
  "benchmarks": {
    "word_count": {"p25": 0, "avg": 0, "p75": 0, "min": 0, "target_max": 0},
    "headings_h2": {"p25": 0, "avg": 0, "p75": 0, "min": 0, "target_max": 0},
    "paragraphs": {"p25": 0, "avg": 0, "p75": 0, "min": 0, "target_max": 0},
    "images": {"p25": 0, "avg": 0, "p75": 0, "min": 0, "target_max": 0}
  },
  "competitor_scores": {},
  "avg_score": 0,
  "top_score": 0
}
```
