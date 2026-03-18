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

## Configuración post-instalación

Luego de instalar los skills, hay tres configuraciones adicionales necesarias para que funcionen correctamente.

---

### 1. Configurar los MCP servers

El repositorio incluye dos archivos de ejemplo que cubren toda la configuración necesaria:

- **`.mcp.json.example`** — estructura completa de MCPs con placeholders para paths y credenciales
- **`.env.example`** — todas las variables de entorno requeridas con descripción de cada una

**Paso 1 — Copia los archivos de ejemplo:**

```bash
cp .mcp.json.example .mcp.json
cp .env.example .env
```

**Paso 2 — Edita `.mcp.json`** reemplazando los paths `/ruta/a/...` con las rutas reales en tu máquina.

**Paso 3 — Edita `.env`** con tus credenciales reales. Cada variable está comentada con su origen.

> `.env` y `.mcp.json` están en `.gitignore` — nunca se commitean.

**Resumen de MCPs y sus fuentes de credenciales:**

| MCP | Configurado en | Credenciales |
|---|---|---|
| `dataforseo` | `.mcp.json` del proyecto | `DATAFORSEO_LOGIN` + `DATAFORSEO_PASSWORD` en `.env` |
| `gsc` | `.mcp.json` del proyecto | `GSC_CREDENTIALS` (path al JSON) en `.env` |
| `pagespeed` | `.mcp.json` del proyecto | `PAGESPEED_API_KEY` en `.env` |
| `analytics-mcp` | `.mcp.json` del proyecto | `GOOGLE_APPLICATION_CREDENTIALS` en `.env` |
| `chrome-devtools` | Global o proyecto | Sin credenciales |
| `clarity-{proyecto}` | `.mcp.json` del proyecto | `CLARITY_TOKEN_{PROYECTO}` en `.env` |
| `context7` | Global o proyecto | API key en args |

> Los nombres de MCP en esta tabla son los nombres exactos que los skills esperan. Usar un nombre distinto hará que el skill no lo reconozca.

---

### 2. Configurar los MCP de Microsoft Clarity

Si usas Microsoft Clarity, cada proyecto/cliente necesita su propio MCP. El nombre **debe seguir el patrón `clarity-{nombre-proyecto}`**, donde `{nombre-proyecto}` es un identificador legible que tú eliges — no es el dominio ni se deriva automáticamente de él.

**Ejemplos correctos:**
- Dominio `bradfordhill.cl` → MCP llamado `clarity-bradford-hill`
- Dominio `observatoriodelcancer.cl` → MCP llamado `clarity-observatorio-del-cancer`
- Dominio `clinicadrazaror.cl` → MCP llamado `clarity-clinica-dra-zaror`

El skill identifica el MCP correcto por similitud semántica al nombre del negocio, no por match exacto con el dominio. Si el nombre que eliges es razonablemente descriptivo, el skill lo encontrará.

---

### 3. Configurar la ruta de reportes (`SEO_REPORTS_PATH`)

Los reportes y contextos se almacenan en una carpeta configurable. La ruta se resuelve así:

1. Si `$SEO_REPORTS_PATH` está definida en `.claude/settings.json` → se usa esa ruta
2. Si no está definida → se usa `{cwd}/reports` (directorio actual del proyecto) y se advierte al usuario

El directorio se crea automáticamente si no existe.

Para configurar una ruta personalizada, agrega en `.claude/settings.json`:

```json
{
  "env": {
    "SEO_REPORTS_PATH": "/ruta/a/tu/carpeta/reports"
  }
}
```

---

## Sistema de contexto del negocio

Los reportes y contextos se almacenan en una carpeta configurable. La ruta se resuelve así:

1. Si `$SEO_REPORTS_PATH` está definida en `.claude/settings.json` → se usa esa ruta
2. Si no está definida → se usa `{cwd}/reports` (directorio actual del proyecto) y se advierte al usuario

El directorio se crea automáticamente si no existe.

Para configurar una ruta personalizada, agrega en `.claude/settings.json`:

```json
{
  "env": {
    "SEO_REPORTS_PATH": "/ruta/a/tu/carpeta/reports"
  }
}
```

Cada skill verifica si existe `$SEO_REPORTS_PATH/{dominio}/context.md` antes de correr. Si existe, lo lee y adapta sus recomendaciones al negocio.

Para agregar tu propio contexto personalizado:
- Crea archivos `.md` en `$SEO_REPORTS_PATH/{dominio}/context/`
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
