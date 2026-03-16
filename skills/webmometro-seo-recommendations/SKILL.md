---
name: webmometro-seo-recommendations
description: |
  Genera lista de recomendaciones SEO priorizadas para un dominio o keyword.
  Consolida hallazgos de auditorías, KPIs y análisis SERP en un plan de acción accionable.
  Triggers: "recomendaciones seo", "qué mejorar", "plan de acción seo", "prioridades seo"
argument-hint: "[dominio|keyword]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-recommendations — Recomendaciones Priorizadas

Consolida hallazgos de múltiples análisis y genera un plan de acción priorizado.

## Invocación

```
/webmometro-seo recommendations [dominio|keyword]
```

## Flujo de ejecución

1. Lee contexto del negocio `reports/{dominio}/context.md`
2. Lee todos los reportes disponibles en `reports/{dominio}/` y `reports/audits/`
3. Consolida hallazgos por categoría
4. Prioriza según impacto estimado en tráfico/conversiones vs esfuerzo de implementación
5. Genera plan de acción en 3 horizontes temporales
6. Guarda en `reports/recommendations/{dominio}-{fecha}.md`

## Framework de priorización

**Matriz Impacto × Esfuerzo**:
- Quick Wins: alto impacto, bajo esfuerzo → hacer primero
- Proyectos estratégicos: alto impacto, alto esfuerzo → planificar
- Fill-ins: bajo impacto, bajo esfuerzo → cuando haya tiempo
- Evitar: bajo impacto, alto esfuerzo → no hacer

## Template de reporte

```markdown
# Recomendaciones SEO: {dominio}
**Fecha**: {date} | **Basado en**: {reportes analizados}

## Resumen ejecutivo
{3-5 líneas sobre el estado actual y la mayor oportunidad}

## Quick Wins (esta semana)
| Acción | Página/Keyword | Impacto est. | Cómo |
|---|---|---|---|

## Prioridad Alta (este mes)
| Acción | Página/Keyword | Impacto est. | Esfuerzo |
|---|---|---|---|

## Estratégico (próximo trimestre)
| Iniciativa | Descripción | Impacto est. | Recursos |
|---|---|---|---|

## Insights de mejora
- **Mayor oportunidad**: {descripción}
- **Riesgo principal**: {descripción}
- **Acción #1 recomendada**: {acción concreta con justificación}
```
