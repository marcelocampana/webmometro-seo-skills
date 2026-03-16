---
name: webmometro-seo-outline
description: |
  Genera un outline SEO optimizado para una keyword basado en análisis SERP previo.
  Incluye jerarquía H2/H3, word count por sección, zonas de términos y preguntas PAA.
  Triggers: "outline", "estructura del artículo", "generar outline", "esquema de contenido"
argument-hint: "[keyword]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-outline — Generación de Outline SEO

Genera un outline detallado y optimizado para una keyword, basado en el análisis SERP y benchmarks de competidores.

## Invocación

```
/webmometro-seo-outline [keyword]
```

Requiere reportes previos en `reports/{keyword-slug}/`.

## Flujo de ejecución

1. Lee contexto del negocio en `reports/{dominio}/context.md` (si existe)
2. Lee `reports/{keyword-slug}/01-serp-analysis.md` → intención, PAA, related searches
3. Lee `reports/{keyword-slug}/03-benchmarks.json` → word count total y por sección
4. Lee `reports/{keyword-slug}/04-terms-entities.json` → términos a distribuir
5. Analiza los H2/H3 más frecuentes en los competidores
6. Identifica gaps de contenido (ángulos que los competidores no cubren)
7. Genera outline con:
   - H1 optimizado con keyword principal
   - H2/H3 con distribución de términos
   - Word count objetivo por sección
   - Términos clave a incluir por sección
   - Preguntas PAA a responder
   - Zonas de imágenes y links sugeridas
8. Guarda en `reports/{keyword-slug}/05-outline.md`

## Estructura del outline

```markdown
# {H1 con keyword principal}
**Word count objetivo**: {min}-{max} palabras
**Intención**: {intención SERP}

## Introducción (~{n} palabras)
- Responder la pregunta principal en los primeros 100 tokens
- Términos a incluir: {lista}

## {H2} (~{n} palabras)
### {H3} (~{n} palabras)
- Términos clave: {lista}
- Preguntas PAA a responder: {lista}

## {H2} (~{n} palabras)
...

## Conclusión (~{n} palabras)
- CTA sugerido según objetivo: {objetivo del negocio}

## FAQ (si aplica)
- ¿{pregunta PAA}?
- ¿{pregunta PAA}?
```

## Template de reporte

Ver [references/outline-template.md](references/outline-template.md)
