---
name: webmometro-seo-terms
description: |
  Extrae términos NLP, entidades semánticas y frases clave de los competidores del SERP.
  Genera la lista de términos que debe incluir un contenido para ser semánticamente completo.
  Triggers: "términos nlp", "entidades seo", "qué palabras incluir", "análisis semántico"
argument-hint: "[keyword]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-terms — Extracción de Términos NLP

Analiza los competidores del SERP para identificar los términos y entidades que un contenido debe incluir para ser semánticamente relevante.

## Invocación

```
/webmometro-seo-terms [keyword]
```

Requiere `reports/{keyword-slug}/02-competitors.md` previo.

## Flujo de ejecución

1. Lee `reports/{keyword-slug}/02-competitors.md` → obtiene el análisis NLP por competidor
2. Consolida todos los términos encontrados
3. Calcula frecuencia normalizada (apariciones / 1000 palabras) por término
4. Clasifica por tipo: entidad, concepto, modificador, pregunta
5. Asigna peso según frecuencia y posición (en headings = peso mayor)
6. Genera rango objetivo de frecuencia: [min_freq, max_freq] por término
7. Guarda en `reports/{keyword-slug}/04-terms-entities.json`

## Clasificación de términos

| Tipo | Descripción | Ejemplo |
|---|---|---|
| Entidad principal | El tema central del contenido | keyword principal |
| Entidad relacionada | Conceptos directamente relacionados | sinónimos, variantes |
| Entidad de soporte | Conceptos que dan contexto | marcas, lugares, personas |
| Modificador | Adjetivos y calificadores frecuentes | "mejor", "profesional" |
| Pregunta frecuente | Questions encontradas en PAA y contenido | "¿cómo...?", "¿cuál...?" |

## Output JSON

```json
{
  "keyword": "{keyword}",
  "snapshot_id": "{snapshot_id}",
  "terms": [
    {
      "term": "{término}",
      "type": "entity|concept|modifier|question",
      "weight": 0.0,
      "frequency_per_1000w": {"min": 0, "avg": 0, "max": 0},
      "in_headings": true,
      "competitors_using": 0
    }
  ]
}
```

## Template de reporte

Ver [references/terms-template.md](references/terms-template.md)
