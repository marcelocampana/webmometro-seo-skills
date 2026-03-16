---
name: webmometro-seo-clusters
description: |
  Crea el mapa de clústeres de contenido para Topic Authority.
  Organiza keywords en pilares temáticos con estructura hub-and-spoke y estrategia de links internos.
  Triggers: "clusters", "topic authority", "mapa de contenido", "pilares de contenido", "content clusters"
argument-hint: "[dominio | keyword-pilar]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-clusters — Topic Authority & Content Clusters

Diseña la arquitectura de contenido basada en clústeres temáticos para construir autoridad tópica.

## Invocación

```
/webmometro-seo clusters [dominio]
/webmometro-seo clusters [keyword-pilar]
```

## Flujo de ejecución

1. Lee contexto del negocio `reports/{dominio}/context.md`
2. Lee keyword research disponible en `reports/{dominio}/keywords/`
3. `mcp__dataforseo__labs_google_related_keywords` → keywords relacionadas por semántica
4. `mcp__dataforseo__labs_google_keyword_suggestions` → sugerencias de keywords
5. Agrupa keywords en clústeres temáticos (pilares + subtemas)
6. Identifica contenido existente que ya cubre cada subtema (via GSC)
7. Detecta gaps: subtemas sin cobertura
8. Diseña estructura de links internos entre páginas del clúster
9. Guarda en `reports/{dominio}/clusters-{fecha}.md`

## Estructura hub-and-spoke

```
Pilar (hub): {keyword principal — 2000+ palabras}
├── Subtema 1: {keyword relacionada — 1000-1500 palabras}
├── Subtema 2: {keyword relacionada — 1000-1500 palabras}
├── Subtema 3: {keyword relacionada — 1000-1500 palabras}
└── Subtema N: {keyword relacionada}
```

## Template de reporte

```markdown
# Mapa de Clústeres: {dominio}
**Fecha**: {date}

## Clúster 1: {tema pilar}
**Página pilar**: {url o "por crear"}
**Keyword pilar**: {keyword} | Vol: {n}/mes | KD: {n}

### Subtemas
| Keyword | Estado | URL | Vol/mes | Prioridad |
|---|---|---|---|---|
| {keyword} | Publicado/Por crear | {url} | {n} | Alta/Media/Baja |

### Links internos sugeridos
- {pilar} → {subtema}: anchor "{anchor}"
- {subtema} → {pilar}: anchor "{anchor}"

## Gaps de contenido identificados
| Keyword | Vol/mes | KD | Tipo de contenido sugerido |
|---|---|---|---|
```
