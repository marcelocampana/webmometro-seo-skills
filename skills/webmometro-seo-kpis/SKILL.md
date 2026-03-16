---
name: webmometro-seo-kpis
description: |
  Dashboard combinado de KPIs: GSC + Core Web Vitals (PageSpeed) + rank overview (DataForSEO).
  Vista consolidada del estado del sitio en un solo reporte.
  Triggers: "kpis", "métricas del sitio", "dashboard seo", "estado del sitio", "performance seo"
argument-hint: "[dominio] [período: 7d|28d|90d]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-kpis — Dashboard de KPIs

Vista consolidada del estado del sitio combinando datos de GSC, PageSpeed y DataForSEO.

## Invocación

```
/webmometro-seo kpis [dominio] [período]
```

Default período: `28d`

## Flujo de ejecución

1. `mcp__gsc__search_analytics` → clicks, impressions, CTR, position del período
2. `mcp__gsc__enhanced_search_analytics` → comparación vs período anterior
3. `mcp__gsc__detect_quick_wins` → oportunidades de posición 4-10
4. Para top 5 páginas: `mcp__pagespeed__analyze_pagespeed` → LCP, CLS, INP, performance score
5. `mcp__dataforseo__labs_google_domain_rank_overview` → rank overview del dominio
6. Guarda en `reports/kpis/{dominio}-{fecha}.md`

> Para análisis GSC más detallado (cuadrante de keywords, brand vs non-brand, anomalías):
> usar `/webmometro-seo gsc [subcomando] [dominio]`

## Template de reporte

```markdown
# KPIs del Sitio: {dominio}
**Período**: {start} → {end}

## Performance Search Console
| Métrica | Valor | vs período anterior |
|---|---|---|
| Clicks | {n} | {±%} |
| Impressions | {n} | {±%} |
| CTR promedio | {n}% | {±pts} |
| Posición promedio | {n} | {±} |

## Core Web Vitals (top 5 páginas)
| URL | LCP | CLS | INP | Score Mobile | Score Desktop |
|---|---|---|---|---|---|

## Quick Wins disponibles
| Keyword | Posición | Impresiones | CTR | Acción |
|---|---|---|---|---|

## Insights de mejora
- **Página con mayor oportunidad**: {url} — {razón}
- **Problema técnico prioritario**: {descripción}
- **Acción recomendada esta semana**: {acción concreta}
```
