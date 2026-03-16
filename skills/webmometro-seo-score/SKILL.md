---
name: webmometro-seo-score
description: |
  Calcula el Content Score de un archivo de contenido comparándolo con benchmarks reales del SERP.
  Evalúa estructura, términos NLP, topics, higiene on-page y facts/AI search.
  Triggers: "content score", "score contenido", "puntaje seo", "evaluar contenido", "calificar artículo"
argument-hint: "[archivo.md] [keyword]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-score — Content Score

Calcula el Content Score de un contenido comparándolo con los competidores reales del SERP.

## Invocación

```
/webmometro-seo score [archivo.md] [keyword]
```

## Modos de scoring

**live_score** (Componentes 1+2, máx 75 pts):
- Solo requiere benchmarks.json + terms_entities.json
- Sin llamadas MCP adicionales → rápido, apto para feedback en tiempo real
- Display: raw_live / 0.75 (normalizado a /100)

**deep_score** (Componentes 1+2+3+4+bonus, máx 100+15 pts):
- Requiere análisis OnPage completo (links, meta, PAA coverage, Facts)
- Solo disponible tras flujo completo

Siempre mostrar: `Score: {n} (deep) | Live preview: {n}`

## Componentes del score

### Componente 1 — Estructura (máx 20 pts)
Compara word count, H2s, párrafos e imágenes vs rangos objetivo de benchmarks.

### Componente 2 — Términos + Entidades (máx 55 pts)
Evalúa cobertura y frecuencia de términos del `04-terms-entities.json`.
- Por cada término: `min(actual/target, 1.5) × weight × 55`

### Componente 3 — Topics & Questions (máx 15 pts)
PAA coverage: qué % de las preguntas del SERP responde el contenido.

### Componente 4 — Higiene On-Page (máx 10 pts)
- Keyword en H1 (requerido)
- Keyword en primeros 100 tokens
- Title tag optimizado
- Meta description presente
- Links internos en rango

### Bonus — Facts / AI Search (máx 15 pts)
Claims verificables con fuente, datos estadísticos, citas de expertos.
Display normalizado: score total / 1.15

## Scores de referencia (leave-one-out)

```
avg_score = media de competitor scores (método leave-one-out)
top_score = max de competitor scores

Display: Mi Score: {n} | Avg: {avg} | Top: {top}
→ Objetivo mínimo: superar el Avg
→ Objetivo ambicioso: ≥ Top score
```

## Bandas de calificación

| Rango | Banda | Color |
|---|---|---|
| 90-100 | Exceptional | Verde oscuro |
| 70-89 | Strong | Verde |
| 50-69 | Acceptable | Amarillo |
| 30-49 | Below Standard | Naranja |
| 0-29 | Needs Rewrite | Rojo |

## Template de reporte

Ver [references/score-rubric.md](references/score-rubric.md)
