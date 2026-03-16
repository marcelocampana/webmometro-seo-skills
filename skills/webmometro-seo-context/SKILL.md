---
name: webmometro-seo-context
description: |
  Genera y actualiza el perfil de contexto del negocio para un dominio.
  Analiza el sitio con MCPs para inferir qué hace el negocio, a quién le vende,
  sus competidores y estrategia de contenido. Genera un borrador que el usuario valida.
  Todos los demás skills webmometro-seo leen este contexto automáticamente.
  Triggers: "context", "perfil del negocio", "contexto del sitio", "definir negocio", "configurar dominio"
argument-hint: "[dominio]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-context — Contexto del Negocio

Genera el perfil del negocio para un dominio. Todos los skills webmometro-seo lo leen automáticamente antes de cada análisis, permitiéndoles hacer recomendaciones contextualizadas al negocio en lugar de análisis genéricos.

## Invocación

```
/webmometro-seo context [dominio]
```

## Flujo de ejecución

### Paso 1 — Análisis automático

Usa los MCPs para inferir el contexto sin preguntar nada al usuario:

1. `mcp__dataforseo__onpage_task_post` en la homepage → title, meta, H1-H2, body text
2. `mcp__gsc__search_analytics` → top 20 keywords por clicks (últimos 28 días)
3. `mcp__dataforseo__serp_google_organic_live` con las top 3 keywords → competidores recurrentes
4. `mcp__dataforseo__labs_google_categories_for_domain` → categoría de industria

### Paso 2 — Borrador y validación

Presenta el borrador al usuario:

```
He analizado [dominio] y esto es lo que inferí. Corrígeme en lo que esté mal:

**Negocio**: [descripción en 1-2 líneas]
**Objetivo principal**: [leads / ventas / tráfico informacional / marca]
**Cliente ideal**: [descripción]
**Propuesta de valor**: [diferenciador]
**Competidores directos**: [lista de dominios]
**Pilares de contenido**: [temas inferidos de las keywords]
**Tono de marca**: [formal / conversacional / técnico]

¿Qué ajustarías?
```

### Paso 3 — Guardado

Incorpora correcciones y guarda en `reports/{dominio}/context.md`.

Al finalizar informa:
> "Contexto guardado. Si tienes pautas internas, marcos SEO o guías de marca, agrégalos como archivos `.md` en `reports/{dominio}/context/` — los skills los leerán automáticamente con prioridad sobre este archivo."

## Estructura de archivos

```
reports/{dominio}/
├── context.md              ← generado por este skill
└── context/                ← archivos propios del usuario (prioridad)
    ├── marco-seo.md
    ├── brand-guidelines.md
    └── [cualquier .md]
```

## Cómo leen el contexto los demás skills

```
1. Verificar si existe reports/{dominio}/context.md → leerlo
2. Verificar si existe reports/{dominio}/context/*.md → leerlos (prioridad sobre context.md)
3. Si no existe → sugerir: "/webmometro-seo context {dominio}"
```

## Template de reporte

Ver [references/context-template.md](references/context-template.md)
