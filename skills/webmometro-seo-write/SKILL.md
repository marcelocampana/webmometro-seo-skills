---
name: webmometro-seo-write
description: |
  Asiste la escritura de contenido SEO optimizado con feedback en tiempo real.
  Usa el outline y los términos NLP para guiar la escritura sección por sección.
  Triggers: "escribir contenido", "redactar artículo", "asistir escritura", "write seo"
argument-hint: "[keyword]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-write — Asistencia de Escritura

Asiste la escritura de contenido SEO optimizado, proporcionando feedback en tiempo real sobre términos, estructura y score.

## Invocación

```
/webmometro-seo write [keyword]
```

Requiere reportes previos en `reports/{keyword-slug}/`.

## Flujo de ejecución

1. Lee contexto del negocio `reports/{dominio}/context.md`
2. Lee `reports/{keyword-slug}/05-outline.md` → estructura a seguir
3. Lee `reports/{keyword-slug}/04-terms-entities.json` → términos a cubrir
4. Lee `reports/{keyword-slug}/03-benchmarks.json` → rangos objetivo
5. Modo de escritura asistida:
   - Por cada sección del outline: sugiere contenido + señala términos que faltan
   - Live score parcial después de cada sección completada
   - Alerta si una sección está por encima o debajo del word count objetivo
6. Al terminar: corre `deep_score` completo
7. Guarda el borrador en `reports/{keyword-slug}/draft-{fecha}.md`

## Feedback en tiempo real

Al completar cada sección, mostrar:
```
✅ Sección: {H2}
   Palabras: {n} (objetivo: {min}-{max})
   Términos cubiertos: {n}/{total}
   Términos faltantes: {lista de los más importantes}
   Live score parcial: {n}/100
```

## Reglas de escritura

1. Responder la pregunta principal en los primeros 100 tokens
2. Incluir keyword principal en H1, primeros 100 tokens y al menos 1 H2
3. Distribuir términos NLP naturalmente — no forzarlos
4. Cada sección debe responder una pregunta o resolver un problema concreto
5. Usar el tono de voz definido en `context.md` del dominio
6. Incluir CTA alineado con el objetivo del negocio

## Modos

- **Modo guiado**: Claude redacta sección por sección con tu aprobación
- **Modo feedback**: Tú redactas, Claude evalúa y sugiere mejoras
- **Modo borrador**: Claude genera el borrador completo de una vez
