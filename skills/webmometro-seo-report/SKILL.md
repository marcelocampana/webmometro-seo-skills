---
name: webmometro-seo-report
description: |
  Genera un reporte SEO completo y consolidado para una keyword o dominio.
  Combina todos los análisis disponibles en un documento ejecutivo cohesivo.
  Triggers: "reporte seo", "informe seo", "reporte completo", "generar reporte"
argument-hint: "[keyword | dominio]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-report — Reporte Completo

Genera un reporte consolidado que combina todos los análisis disponibles en un documento ejecutivo.

## Invocación

```
/webmometro-seo report [keyword]    ← reporte de contenido para una keyword
/webmometro-seo report [dominio]    ← reporte del sitio completo
```

## Flujo de ejecución

1. Lee todos los reportes disponibles en `reports/{keyword-slug}/` o `reports/{dominio}/`
2. Lee contexto del negocio `reports/{dominio}/context.md`
3. Consolida en un único documento ejecutivo
4. Genera sección de insights y próximos pasos
5. Guarda en `reports/full-reports/{keyword|dominio}-{fecha}.md`

## Estructura del reporte completo

```markdown
# Reporte SEO: {keyword | dominio}
**Fecha**: {date} | **Período analizado**: {período}

## Resumen Ejecutivo
{5-7 líneas con los hallazgos más importantes y la oportunidad principal}

## Estado Actual
### Métricas clave
### Posición en el mercado (vs competidores)

## Análisis de Contenido
### Content Score: {n}/100
### Términos y cobertura semántica

## Análisis Técnico
### SEO Health Index: {n}/100
### Core Web Vitals

## Oportunidades de Keywords
### Quick Wins
### Potencial de crecimiento

## Análisis de Competidores
### Benchmarks del mercado
### Brechas identificadas

## Insights Estratégicos
- Oportunidad principal
- Riesgo ignorado
- Palanca de crecimiento

## Plan de Acción
### Esta semana
### Este mes
### Este trimestre
```
