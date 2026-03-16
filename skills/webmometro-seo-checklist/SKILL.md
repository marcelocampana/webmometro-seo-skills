---
name: webmometro-seo-checklist
description: |
  Crea y actualiza checklists SEO para un contenido específico.
  Genera una lista de verificación personalizada basada en el análisis SERP y los benchmarks.
  Triggers: "checklist seo", "lista de verificación", "crear checklist", "verificar contenido"
argument-hint: "[keyword] [url-opcional]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-checklist — Checklist SEO

Genera y gestiona checklists SEO personalizados para cada contenido.

## Invocación

```
/webmometro-seo checklist [keyword]
/webmometro-seo checklist [keyword] [url]  ← para actualizar con estado actual
```

## Flujo de ejecución

1. Lee reportes disponibles en `reports/{keyword-slug}/`
2. Lee contexto del negocio `reports/{dominio}/context.md`
3. Genera checklist personalizado con items específicos (no genérico)
4. Si se pasa URL: verifica automáticamente los items que se puedan comprobar via MCP
5. Guarda en `reports/{keyword-slug}/checklist.md`

## Categorías del checklist

**Keyword y estructura**
- [ ] Keyword principal en H1
- [ ] Keyword en primeros 100 tokens
- [ ] Keyword en al menos 1 H2
- [ ] Word count en rango [{min}-{max}]
- [ ] H2s en rango [{min}-{max}]

**Términos NLP**
- [ ] {término 1} incluido (frecuencia: {min}-{max}/1000w)
- [ ] {término 2} incluido
- [ ] {n} de {total} términos prioritarios cubiertos

**Preguntas PAA**
- [ ] ¿{pregunta}? respondida
- [ ] ¿{pregunta}? respondida

**On-Page técnico**
- [ ] Title tag: {min}-{max} caracteres con keyword
- [ ] Meta description: 150-160 caracteres con CTA
- [ ] URL amigable y con keyword
- [ ] Imágenes en rango [{min}-{max}] con alt text
- [ ] Links internos en rango [{min}-{max}]
- [ ] Canonical tag presente

**Contenido y conversión**
- [ ] CTA alineado con objetivo: {objetivo}
- [ ] Tono de marca según: {tono definido en context.md}
