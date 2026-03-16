---
name: webmometro-seo-rank-tracker
description: |
  Rastrea las posiciones de keywords en Google a lo largo del tiempo.
  Compara posiciones actuales vs históricas y genera alertas de cambios significativos.
  Triggers: "rank tracking", "posiciones keywords", "rastrear posiciones", "seguimiento rankings"
argument-hint: "[dominio] [keywords-file]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-rank-tracker — Rank Tracking

Rastrea posiciones de keywords y detecta cambios significativos a lo largo del tiempo.

## Invocación

```
/webmometro-seo rank-tracker [dominio]                    ← usa keywords del contexto
/webmometro-seo rank-tracker [dominio] [keywords-file]    ← usa lista personalizada
```

## Flujo de ejecución

1. Lee contexto del negocio `reports/{dominio}/context.md` → keywords prioritarias
2. Si se pasa archivo de keywords: lee la lista
3. `mcp__dataforseo__serp_google_organic_live` para cada keyword → posición actual del dominio
4. Lee historial previo de `reports/rank-tracker/{dominio}/` → calcula delta
5. Detecta cambios significativos:
   - Subida > 5 posiciones → oportunidad
   - Caída > 5 posiciones → alerta
   - Entrada en top 10 → logro
   - Salida de top 10 → urgente revisar
6. Guarda snapshot en `reports/rank-tracker/{dominio}/{fecha}.md`

## Template de reporte

```markdown
# Rank Tracker: {dominio}
**Fecha**: {date} | **Keywords monitoreadas**: {n}

## Resumen de cambios
| Estado | Keywords |
|---|---|
| Subieron | {n} |
| Bajaron | {n} |
| Sin cambio | {n} |
| Nuevas en top 10 | {n} |

## Cambios significativos
| Keyword | Posición anterior | Posición actual | Delta | Alerta |
|---|---|---|---|---|

## Ranking completo
| Keyword | Posición | Vol/mes | URL rankeando | Cambio |
|---|---|---|---|---|

## Insights de mejora
- **Mayor subida**: {keyword} +{n} posiciones
- **Mayor caída**: {keyword} -{n} posiciones → revisar urgente
- **Próxima en entrar al top 10**: {keyword} en posición {n}
```
