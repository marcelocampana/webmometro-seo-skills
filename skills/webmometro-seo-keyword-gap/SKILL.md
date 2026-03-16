---
name: webmometro-seo-keyword-gap
description: |
  Análisis de gap de keywords entre un dominio y sus competidores.
  Identifica keywords por las que los competidores rankean pero el dominio no,
  las ordena por oportunidad y genera un plan de contenido priorizado.
  Triggers: "keyword gap", "gap de keywords", "keywords competidores", "oportunidades de keywords",
  "qué keywords tienen mis competidores", "analizar brecha de keywords"
argument-hint: "[dominio] [competidor1] [competidor2?]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-keyword-gap — Keyword Gap Analysis

Identifica keywords que tus competidores tienen y tú no, ordenadas por oportunidad real de tráfico.

## Invocación

```
/webmometro-seo keyword-gap [dominio] [competidor1]
/webmometro-seo keyword-gap [dominio] [competidor1] [competidor2]
/webmometro-seo keyword-gap [dominio]                             ← usa competidores del context.md
```

## Flujo de ejecución

1. Lee contexto del negocio `reports/{dominio}/context.md` → competidores declarados
2. Si no se pasan competidores explícitos → usa los del context.md (mínimo 2)
3. Si no hay context.md → `mcp__dataforseo__labs_google_competitors_domain` para obtenerlos automáticamente
4. `mcp__dataforseo__labs_google_domain_intersection` → keywords en común entre dominios
5. `mcp__dataforseo__labs_google_ranked_keywords` para cada competidor → keywords que rankean
6. `mcp__dataforseo__labs_google_ranked_keywords` para el dominio propio → keywords actuales
7. Calcula el gap: keywords del competidor NO presentes en el dominio
8. `mcp__dataforseo__labs_google_bulk_keyword_difficulty` para las top 50 keywords del gap → KD
9. Clasifica cada keyword del gap por tipo de oportunidad:
   - **Quick Win**: KD < 30, volumen > 100, intención clara
   - **Oportunidad Media**: KD 30-60, volumen > 200
   - **Largo Plazo**: KD > 60 o volumen muy alto — requiere autoridad
   - **Contenido de soporte**: variantes de long tail, bajo volumen individual pero alto agregado
10. Agrupa keywords del gap por clúster temático
11. Genera plan de contenido priorizado por impacto estimado
12. Guarda en `reports/keyword-gap/{dominio}-vs-{competidores}-{fecha}.md`

## Criterios de priorización

Fórmula de oportunidad = (Volumen × CTR estimado por posición) / KD

Ajustes:
- +20% si el dominio ya tiene autoridad tópica en ese clúster (tiene páginas relacionadas)
- +15% si la keyword tiene SERP features (featured snippet, PAA) → mayor CTR potencial
- −20% si la keyword requiere un tipo de contenido que el dominio no tiene (ej. e-commerce sin tienda)

## Template de reporte

```markdown
# Keyword Gap: {dominio} vs {competidores}
**Fecha**: {date} | **Keywords analizadas**: {n}

## Resumen del gap
| Métrica | Valor |
|---|---|
| Keywords competidores (total) | {n} |
| Keywords propias (total) | {n} |
| Gap identificado | {n} keywords |
| Gap priorizado (top oportunidades) | {n} keywords |

## Top oportunidades por tipo

### Quick Wins (acción inmediata — KD < 30)
| Keyword | Volumen/mes | KD | Competidor que rankea | Posición comp. | Tipo de contenido |
|---|---|---|---|---|---|

### Oportunidades Media (1-3 meses — KD 30-60)
| Keyword | Volumen/mes | KD | Competidor que rankea | Posición comp. | Tipo de contenido |
|---|---|---|---|---|---|

### Largo Plazo (> 3 meses — KD > 60)
| Keyword | Volumen/mes | KD | Competidor que rankea | Nota |
|---|---|---|---|---|

## Gap por clúster temático
| Clúster | Keywords en gap | Volumen total | Prioridad | Contenido sugerido |
|---|---|---|---|---|

## Plan de contenido priorizado
| Prioridad | Keyword principal | Tipo | Volumen | KD | Competidores que rankean |
|---|---|---|---|---|---|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |

## Keywords en común (temas donde ya compites)
| Keyword | Tu posición | Competidor | Posición comp. | Brecha |
|---|---|---|---|---|

## Insights de mejora
- **Mayor oportunidad inmediata**: {keyword con mejor ratio volumen/KD}
- **Clúster más rentable ignorado**: {tema con mayor volumen agregado sin cobertura}
- **Competidor a priorizar**: {el que tiene las keywords más alcanzables}
- **Patrón del gap**: {qué tipo de contenido o intención domina el gap — informacional, transaccional, etc.}
- **Siguiente acción**: `/webmometro-seo outline [keyword]` o `/webmometro-seo clusters [dominio]`
```
