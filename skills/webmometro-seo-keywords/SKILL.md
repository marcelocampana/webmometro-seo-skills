---
name: webmometro-seo-keywords
description: |
  Keyword research completo para un dominio o semilla. Combina DataForSEO y GSC para
  descubrir keywords con volumen, dificultad e intención. Genera mapa de oportunidades.
  Triggers: "keyword research", "investigar keywords", "encontrar keywords", "oportunidades de keywords"
argument-hint: "[semilla | dominio] [opciones]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-keywords — Keyword Research

Keyword research completo combinando datos de demanda (DataForSEO) con rendimiento real (GSC).

## Invocación

```
/webmometro-seo keywords [semilla]           ← research desde keyword semilla
/webmometro-seo keywords [dominio]           ← keywords del dominio actual
/webmometro-seo keywords [semilla] --deep    ← incluye gaps vs competidores
```

## Flujo de ejecución

1. Lee contexto del negocio `reports/{dominio}/context.md`
2. `mcp__dataforseo__labs_google_keyword_ideas` → keywords relacionadas con la semilla
3. `mcp__dataforseo__keywords_google_ads_search_volume` → volumen mensual + CPC + competencia
4. `mcp__dataforseo__labs_google_bulk_keyword_difficulty` → dificultad KD de cada keyword
5. `mcp__dataforseo__labs_google_search_intent` → intención (informacional/transaccional/navegacional/comercial)
6. `mcp__gsc__search_analytics` → qué keywords ya traen tráfico real al sitio
7. `mcp__gsc__detect_quick_wins` → oportunidades de posición 4-10 ya existentes
8. Clasifica keywords por oportunidad: volumen × (1/dificultad) × intent_match
9. Guarda en `reports/{dominio}/keywords/{semilla}-{fecha}.md`

## Clasificación de oportunidades

| Categoría | Criterio |
|---|---|
| Quick Win | KD < 30, volumen > 100, pos 4-10 en GSC |
| Oportunidad media | KD 30-60, volumen > 500, sin ranking actual |
| Objetivo largo plazo | KD > 60, volumen > 1000, alta intención comercial |
| Ignorar | KD > 80, volumen < 50, intención no alineada |

## Template de reporte

```markdown
# Keyword Research: {semilla}
**Dominio**: {dominio} | **Fecha**: {date}

## Resumen de oportunidades
| Categoría | Total keywords | Volumen total/mes |
|---|---|---|

## Quick Wins (hacer primero)
| Keyword | Vol/mes | KD | Posición actual | Intención |
|---|---|---|---|---|

## Oportunidades medias
| Keyword | Vol/mes | KD | Intención | Tipo de contenido sugerido |
|---|---|---|---|---|

## Keywords ya rankeando (GSC)
| Keyword | Posición | Clicks/mes | CTR | Oportunidad |
|---|---|---|---|---|
```
