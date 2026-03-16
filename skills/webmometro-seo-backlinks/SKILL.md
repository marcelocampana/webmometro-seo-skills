---
name: webmometro-seo-backlinks
description: |
  Análisis del perfil de backlinks de un dominio. Evalúa autoridad, diversidad,
  anchor text, backlinks tóxicos y oportunidades de link building.
  Triggers: "backlinks", "perfil de enlaces", "link building", "autoridad del dominio", "enlaces externos"
argument-hint: "[dominio]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-backlinks — Análisis de Backlinks

Analiza el perfil de backlinks del dominio para evaluar autoridad y oportunidades de link building.

## Invocación

```
/webmometro-seo backlinks [dominio]
```

## Flujo de ejecución

1. `mcp__dataforseo__backlinks_summary` → métricas generales: DA, PA, CF, TF, total backlinks, referring domains
2. `mcp__dataforseo__backlinks_referring_domains` → dominios que enlazan con métricas de autoridad
3. `mcp__dataforseo__backlinks_anchors` → distribución de anchor text
4. `mcp__dataforseo__backlinks_bulk_spam_score` → detección de backlinks tóxicos
5. `mcp__dataforseo__backlinks_timeseries_summary` → evolución histórica de backlinks
6. Compara métricas vs top 3 competidores del SERP principal
7. Identifica oportunidades de link building (dominios que enlazan a competidores pero no al sitio)
8. Guarda en `reports/backlinks/{dominio}-{fecha}.md`

## Template de reporte

```markdown
# Análisis de Backlinks: {dominio}
**Fecha**: {date}

## Métricas de autoridad
| Métrica | Valor | vs Competidor 1 | vs Competidor 2 |
|---|---|---|---|
| Domain Authority | | | |
| Citation Flow | | | |
| Trust Flow | | | |
| Referring Domains | | | |
| Total Backlinks | | | |

## Distribución de anchor text
| Anchor | % | Tipo |
|---|---|---|
| {keyword exacta} | {n}% | Exact match |
| {marca} | {n}% | Brand |
| {url} | {n}% | URL |
| {genérico} | {n}% | Generic |

## Backlinks tóxicos detectados
| URL | Spam Score | Acción recomendada |
|---|---|---|

## Oportunidades de link building
| Dominio | DA | Enlaza a competidores | Cómo conseguirlo |
|---|---|---|---|

## Insights de mejora
- **Estado del perfil**: {saludable / necesita diversificación / riesgo de penalización}
- **Brecha vs competidores**: {descripción}
- **Acción prioritaria**: {descripción}
```
