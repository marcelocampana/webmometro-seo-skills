---
name: webmometro-seo-ai-watcher
description: |
  Monitorea la visibilidad de una marca o keyword en AI search: ChatGPT, Perplexity,
  Google AI Overviews y Claude. Analiza si el sitio es citado y por qué los competidores sí aparecen.
  Triggers: "ai watcher", "visibilidad ai", "chatgpt menciona", "perplexity", "ai overviews",
  "geo audit", "citabilidad ia", "aparecer en ia"
argument-hint: "[marca | keyword] [dominio]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-ai-watcher — AI Search Watcher

Monitorea la visibilidad en plataformas de AI search y genera estrategia para mejorar la citabilidad.

## Invocación

```
/webmometro-seo ai-watcher [marca|keyword] [dominio]
```

## Flujo de ejecución

1. Lee contexto del negocio `reports/{dominio}/context.md`
2. Consulta múltiples plataformas AI:
   - `mcp__dataforseo__ai_chatgpt_llm_responses_live` → respuesta de ChatGPT
   - `mcp__dataforseo__ai_perplexity_llm_responses_live` → respuesta de Perplexity
   - `mcp__dataforseo__ai_gemini_llm_responses_live` → respuesta de Gemini
   - `mcp__dataforseo__ai_claude_llm_responses_live` → respuesta de Claude
3. Analiza si el dominio/marca aparece citado en cada plataforma
4. Identifica qué fuentes sí son citadas (competidores)
5. Analiza por qué esas fuentes son citadas (estructura, autoridad, contenido)
6. Verifica accesibilidad para AI bots (robots.txt: GPTBot, ClaudeBot, PerplexityBot, Google-Extended)
7. Evalúa citabilidad del contenido actual (estructura extractable, estadísticas, citas)
8. Guarda en `reports/ai-watcher/{dominio}-{fecha}.md`

## Factores de citabilidad (GEO)

Basado en investigación de Princeton GEO:
- +40% citabilidad con citas y referencias verificables
- +37% con estadísticas y datos numéricos
- +30% con citas de expertos

## Template de reporte

```markdown
# AI Search Watcher: {marca | keyword}
**Dominio**: {dominio} | **Fecha**: {date}

## Visibilidad por plataforma
| Plataforma | ¿Aparece? | ¿Citado? | Posición |
|---|---|---|---|
| ChatGPT | ✅/❌ | ✅/❌ | {n} |
| Perplexity | ✅/❌ | ✅/❌ | {n} |
| Gemini | ✅/❌ | ✅/❌ | {n} |
| Claude | ✅/❌ | ✅/❌ | {n} |

## Fuentes citadas por los AI (competidores)
| Dominio | Plataformas | Por qué es citado |
|---|---|---|

## Accesibilidad AI bots
| Bot | Permitido en robots.txt |
|---|---|
| GPTBot | ✅/❌ |
| ClaudeBot | ✅/❌ |
| PerplexityBot | ✅/❌ |
| Google-Extended | ✅/❌ |

## Score de citabilidad del contenido
| Factor | Estado | Impacto estimado |
|---|---|---|
| Estadísticas con fuente | ✅/❌ | +37% |
| Citas de expertos | ✅/❌ | +30% |
| Referencias verificables | ✅/❌ | +40% |
| Estructura extractable | ✅/❌ | Alto |

## Insights de mejora
- **Principal barrera de citabilidad**: {descripción}
- **Acción con mayor impacto**: {descripción}
- **Contenido prioritario para optimizar para AI**: {páginas/temas}
```
