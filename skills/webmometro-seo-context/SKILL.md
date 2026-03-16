---
name: webmometro-seo-context
description: |
  Genera y actualiza el perfil de contexto del negocio para un dominio.
  Analiza el sitio con MCPs para inferir qué hace el negocio, a quién le vende,
  sus competidores y estrategia de contenido. Genera un borrador que el usuario valida.
  Todos los demás skills webmometro-seo leen este contexto automáticamente.
  Triggers: "context", "perfil del negocio", "contexto del sitio", "definir negocio", "configurar dominio"
argument-hint: "[dominio]"
---

# webmometro-seo-context — Contexto del Negocio

Genera el perfil del negocio para un dominio. Todos los skills webmometro-seo lo leen automáticamente antes de cada análisis, permitiéndoles hacer recomendaciones contextualizadas al negocio en lugar de análisis genéricos.

## Invocación

```
/webmometro-seo context [dominio]
```

## Flujo de ejecución

### Paso 1 — Análisis automático

Usa los MCPs en paralelo para inferir el contexto sin preguntar nada al usuario:

1. `mcp__dataforseo__onpage_task_post` en la homepage → title, meta, H1-H2, body text. Guardar: onpage_score, issues detectados (sin H1, título largo, sin alt text, etc.)
2. `mcp__gsc__search_analytics` → top 20 keywords por clicks (últimos 28 días). Si falla o retorna vacío, continuar sin datos GSC y notificar al usuario.
3. `mcp__dataforseo__labs_google_competitors_domain` (target: dominio, location_code: 2152, language_code: es, limit: 15) → dominios competidores según Google
4. `mcp__dataforseo__labs_google_categories_for_domain` (target: dominio — solo este parámetro) → categoría de industria. Si falla, omitir sin interrumpir el flujo.

Luego, con las top 3 keywords por clicks de GSC:
4. `mcp__dataforseo__serp_google_organic_live` × 3 (location_code: 2152, language_code: es, depth: 10) → dominios orgánicos reales en SERPs relevantes

**Importante**: los resultados de SERP pueden ser archivos grandes. Extraer solo los campos `domain` de cada item orgánico. No asumir competidores que no aparezcan en los datos.

Para ampliar peers organizacionales (organizaciones similares al negocio, no necesariamente competidores SERP):
5. `mcp__dataforseo__serp_google_organic_live` con keyword inferida del tipo "[industria/tipo de organización] [país]" (ej: "fundacion cancer chile", "agencia marketing digital chile") → dominios de organizaciones similares

### Paso 2 — Clasificación de competidores

Con los dominios recopilados, clasificar en dos listas distintas:

**Competidores SERP** — dominios que aparecen en las SERPs de las keywords del negocio. Separar en:
- *Nacionales*: dominios del mismo país
- *Internacionales*: dominios de otros países

Filtrar dominios no relevantes: redes sociales (instagram.com, facebook.com, youtube.com, tiktok.com), Wikipedia, agregadores genéricos.

**Peers organizacionales** — organizaciones del mismo tipo/industria (no necesariamente competidores de contenido). Mínimo 8, idealmente 10+. Útiles para análisis de gaps de contenido y benchmarks de estrategia.

### Paso 3 — Borrador y validación

Presenta el borrador al usuario:

```
He analizado [dominio] y esto es lo que inferí. Corrígeme en lo que esté mal:

**Negocio**: [descripción en 1-2 líneas]
**Objetivo principal**: [leads / ventas / tráfico informacional / marca]
**Cliente ideal**: [descripción]
**Propuesta de valor**: [diferenciador]

**Competidores SERP**
- Nacionales: [lista]
- Internacionales: [lista]

**Peers organizacionales**: [lista — organizaciones similares]

**Pilares de contenido**: [temas inferidos de las keywords]
**Tono de marca**: [formal / conversacional / técnico]

¿Qué ajustarías?
```

### Paso 4 — Guardado

Incorpora correcciones y guarda en `reports/{dominio}/context.md`.

El archivo debe incluir todas las secciones del borrador validado, más:

- **Keywords prioritarias GSC**: tabla con keyword, clicks, impresiones, posición (top 10 por clicks)
- **Notas técnicas**: onpage_score, issues detectados por OnPage API (sin H1, título largo, sin alt text, etc.), CMS detectado
- **Industria**: categoría inferida por DataForSEO (si disponible)

Estas secciones no se presentan al usuario para validar — se guardan directamente desde los datos de los MCPs.

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
