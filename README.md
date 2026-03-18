# webmometro-seo-skills

Sistema completo de 25 skills SEO para Claude Code. Flujo de trabajo end-to-end desde keyword research hasta auditoría, monitoreo y optimización para AI search.

## Instalación

```bash
npx skills add webmometro-seo-skills
```

O clona el repositorio directamente:

```bash
git clone https://github.com/webmometro/webmometro-seo-skills.git
```

## Uso

Todos los skills se invocan desde el orchestrator principal:

```
/webmometro-seo [comando] [argumentos]
```

Para ver todos los comandos disponibles:

```
/webmometro-seo help
```

---

## Skills incluidos (25)

### Orchestrator
| Skill | Descripción |
|---|---|
| `webmometro-seo` | Punto de entrada unificado para todos los comandos |

### Contexto del negocio
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-context` | `context [dominio]` | Genera perfil del negocio que todos los demás skills leen automáticamente |

### Análisis y contenido
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-serp` | `serp [keyword]` | Análisis SERP con snapshot inmutable para scoring reproducible |
| `webmometro-seo-competitors` | — | Análisis profundo de competidores (llamado internamente por otros skills) |
| `webmometro-seo-benchmarks` | — | Calcula P25/avg/P75 de métricas de competidores |
| `webmometro-seo-terms` | — | Extracción NLP: entidades, modificadores, preguntas |
| `webmometro-seo-score` | `score [archivo.md]` | Content Score vs competidores reales del SERP |
| `webmometro-seo-outline` | `outline [keyword]` | Outline SEO con jerarquía H2/H3 y distribución de términos |
| `webmometro-seo-write` | `write [keyword]` | Asistencia de escritura con feedback en tiempo real |
| `webmometro-seo-keywords` | `keywords [semilla]` | Keyword research completo (DataForSEO + GSC) |

### Auditoría
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-audit` | `audit [url]` | Auditoría profunda con Content Score + SEO Health Index |
| | `audit draft [archivo]` | Pre-publicación: audita un borrador antes de publicar |
| | `audit vs [url] [url-comp]` | Comparación directa tu página vs competidor |
| | `audit site [dominio]` | Auditoría del sitio completo (top 20 páginas vía GSC) |
| `webmometro-seo-recommendations` | — | Genera recomendaciones priorizadas por impacto × esfuerzo |
| `webmometro-seo-checklist` | `checklist [url]` | Checklist SEO por página |

### Google Search Console
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-gsc` | `gsc sites` | Lista propiedades verificadas |
| | `gsc performance [dom] [per]` | Métricas generales vs período anterior |
| | `gsc keyword-map [dom] [per]` | Cuadrante: más buscadas / potencial / baja / dormidas |
| | `gsc quick-wins [dom]` | Keywords pos 4-10 con alta impresión y CTR bajo |
| | `gsc brand [dom] [per]` | Brand vs Non-Brand: composición y riesgo |
| | `gsc anomalies [dom]` | Detecta caídas >20% y CTR anómalos |
| | `gsc weekly [dom]` | Resumen ejecutivo semanal |
| | `gsc full [dom] [per]` | Reporte completo GSC |

### Investigación y competencia
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-keyword-gap` | `keyword-gap [dom] [c1] [c2]` | Gap de keywords vs competidores |
| `webmometro-seo-clusters` | `clusters [dom\|keyword]` | Mapa de clústeres para Topic Authority |
| `webmometro-seo-serp-features` | `serp-features [dom\|keywords]` | Monitor de SERP features e impacto en CTR |

### Monitoreo
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-rank-tracker` | `rank-tracker [dom] [kw-file]` | Rastrea posiciones de keywords a lo largo del tiempo |
| `webmometro-seo-ai-watcher` | `ai-watcher [marca\|keyword]` | Visibilidad en AI search: ChatGPT, Perplexity, Gemini, Claude |
| `webmometro-seo-kpis` | `kpis [dominio] [período]` | Dashboard combinado: GSC + PageSpeed + rank overview |

### Perfil y backlinks
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-site-profile` | `site-profile [dominio]` | Perfil SEO completo del dominio |
| `webmometro-seo-backlinks` | `backlinks [dominio]` | Análisis de perfil de backlinks |

### Contenido y marca
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-template` | `template [tipo]` | Templates para 8 tipos de contenido |
| `webmometro-seo-voice` | `voice [dominio]` | Gestión de voz y tono de marca |

### Reportes y mejora
| Skill | Comando | Descripción |
|---|---|---|
| `webmometro-seo-report` | `report [keyword]` | Reporte consolidado completo |
| `webmometro-seo` | `improve [skill]` | Evals A/B + optimización de trigger + instrucciones |
| `webmometro-seo` | `help [skill?]` | Referencia completa de todos los comandos |

---

## Flujo recomendado para un sitio nuevo

```
1. /webmometro-seo context [dominio]         ← perfil del negocio (base de todo)
2. /webmometro-seo keywords [semilla]        ← keyword research
3. /webmometro-seo clusters [dominio]        ← arquitectura de contenido
4. /webmometro-seo serp [keyword]            ← análisis SERP por keyword
5. /webmometro-seo outline [keyword]         ← outline optimizado
6. /webmometro-seo write [keyword]           ← escritura asistida
7. /webmometro-seo audit [url]               ← auditoría post-publicación
8. /webmometro-seo gsc weekly [dominio]      ← seguimiento semanal
```

---

## MCP servers requeridos

Los skills usan los siguientes MCP servers. Configúralos en tu `~/.claude/mcp.json`:

| MCP | Propósito |
|---|---|
| `dataforseo` | SERP, keywords, backlinks, OnPage, labs, domain analytics |
| `gsc` | Google Search Console (search analytics, quick wins, sitemaps) |
| `pagespeed` | Core Web Vitals vía Google PageSpeed Insights API |
| `chrome-devtools` | Screenshots de competidores, DOM renderizado |
| `context7` | Documentación actualizada de librerías |
| `nuxt-ui-remote` | Componentes Nuxt UI (si el stack del cliente es Nuxt) |
| `analytics-mcp` | Google Analytics 4 (para skills de KPIs) |
| `clarity-{proyecto}` | Microsoft Clarity — sesiones, heatmaps, comportamiento de usuario |

### Selección automática del MCP de Microsoft Clarity

Los MCPs de Clarity siguen el patrón `clarity-{nombre-proyecto}`. Cualquier skill que use Clarity debe seleccionar el MCP correcto automáticamente:

1. Extrae el dominio de la URL analizada (ej: `bradfordhill.cl`)
2. Normaliza: minúsculas, sin tildes, espacios → guiones (ej: `bradford-hill`)
3. Usa el MCP cuyo nombre contenga ese fragmento (ej: `clarity-bradford-hill`)
4. Si no hay match, confirma con el usuario
5. Si no existe MCP de Clarity para ese dominio, omite la integración sin error

---

## Sistema de contexto del negocio

Cada skill verifica si existe `reports/{dominio}/context.md` antes de correr. Si existe, lo lee y adapta sus recomendaciones al negocio.

Para agregar tu propio contexto personalizado:
- Crea archivos `.md` en `reports/{dominio}/context/`
- Ejemplos: `marco-seo.md`, `brand-guidelines.md`, `audiencia-objetivo.md`
- Los archivos en `context/` tienen **prioridad** sobre el `context.md` generado automáticamente

---

## Seguridad — Protección contra prompt injection

Todos los skills que leen contenido de URLs externas (competidores) aplican:
1. Sanitización HTML: elimina `<script>`, comentarios, meta tags no estándar
2. Detección de patrones sospechosos: alerta si detecta "ignore previous", "new instructions"
3. Resumen de lo leído antes de incorporar al análisis
4. Scope limitado: solo title, H1-H3, body text, meta description

---

## Estructura del repositorio

```
webmometro-seo-skills/
├── skills/
│   ├── webmometro-seo/                    ← orchestrator
│   │   └── SKILL.md
│   ├── webmometro-seo-context/
│   │   ├── SKILL.md
│   │   └── references/
│   │       └── context-template.md
│   ├── webmometro-seo-audit/
│   │   ├── SKILL.md
│   │   └── references/
│   │       └── audit-template.md
│   ├── webmometro-seo-gsc/
│   │   ├── SKILL.md
│   │   └── references/
│   │       └── gsc-report-template.md
│   └── [23 skills más...]
└── README.md
```

---

## Licencia

MIT — Creado por [Webmometro](https://webmometro.com)
