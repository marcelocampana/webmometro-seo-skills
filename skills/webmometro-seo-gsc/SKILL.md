---
name: webmometro-seo-gsc
description: |
  Análisis completo de Google Search Console para un dominio.
  Cubre rendimiento de búsqueda, cuadrante de keywords (más buscadas / potencial / baja / dormidas),
  brand vs non-brand, detección de anomalías, resumen semanal y gestión de sitemaps.
  Triggers: "gsc", "search console", "google search console", "quick wins gsc",
  "keyword map", "brand vs non-brand", "sitemap", "anomalías seo"
argument-hint: "[subcomando] [dominio] [período: 7d|28d|90d]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-gsc — Google Search Console

Análisis dedicado y completo de Google Search Console. Todos los comandos requieren el dominio explícito (sin archivo de configuración persistente).

**Defaults**: período = `28d`, país = Chile, idioma = español.

## Comandos

| Comando | Descripción |
|---|---|
| `gsc sites` | Lista propiedades GSC verificadas |
| `gsc performance [dom] [per]` | Métricas generales + comparación vs período anterior |
| `gsc keyword-map [dom] [per]` | Cuadrante de keywords (ver abajo) |
| `gsc quick-wins [dom]` | Keywords pos 4-10 con alta impresión y CTR bajo |
| `gsc brand [dom] [per]` | Brand vs Non-Brand: composición y riesgo de dependencia |
| `gsc anomalies [dom]` | Detecta caídas >20%, CTR anómalos, cambios bruscos de posición |
| `gsc weekly [dom]` | Resumen ejecutivo semanal: qué subió, qué bajó, qué hacer |
| `gsc sitemaps [dom]` | Estado de sitemaps + cobertura de indexación |
| `gsc sitemap-submit [dom] [url]` | Enviar/actualizar sitemap |
| `gsc full [dom] [per]` | Reporte completo: todos los módulos en secuencia |

## Cuadrante de Keywords (`keyword-map`)

Usa `mcp__gsc__enhanced_search_analytics` comparando dos períodos:

```
┌──────────────────────────────┬──────────────────────────────┐
│  🚀 POTENCIAL DE CRECIMIENTO  │  ⭐ MÁS BUSCADAS (fuerza)    │
│  Impresiones altas, CTR bajo  │  Top clicks + posición ≤10   │
│  Pos 4-15 → optimizar título, │  → Defender y expandir       │
│  meta, contenido              │                              │
├──────────────────────────────┼──────────────────────────────┤
│  ⚠️  A LA BAJA                │  💤 DORMIDAS                 │
│  Clicks cayendo >20% vs       │  Impresiones bajas, pos >15  │
│  período anterior → revisar   │  → Evaluar si vale la pena   │
└──────────────────────────────┴──────────────────────────────┘
```

Tabla por cuadrante: `Keyword | Posición | Clicks | Impressions | CTR | Δ Clicks % | Intención | Acción sugerida`

## Módulo Brand vs Non-Brand

- Detecta automáticamente keywords de marca (nombre, dominio, variantes, misspellings)
- Calcula % de tráfico brand vs non-brand
- Benchmarks saludables: Brand 20-40% | CTR non-brand >5% | Posición non-brand <5

## Módulo de Anomalías

Flags automáticos:
- Caída de clicks >20% vs período anterior
- CTR < 2% con impresiones > 500
- Salto de posición > 5 puestos en keywords con clicks significativos

## Comando `weekly`

Resumen ejecutivo semanal:
- Top 3 páginas/keywords que más subieron
- Top 3 páginas/keywords que más bajaron
- Quick wins disponibles esta semana
- Una recomendación de acción prioritaria

> Al final de `weekly` y `quick-wins`: "Para aprovechar esta oportunidad: `/webmometro-seo outline [keyword]`"

## Template de reporte

Ver [references/gsc-report-template.md](references/gsc-report-template.md)
