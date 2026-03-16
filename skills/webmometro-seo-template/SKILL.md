---
name: webmometro-seo-template
description: |
  Gestiona templates de tipos de contenido SEO: artículos, landing pages, comparativas, guías, etc.
  Crea, lista y aplica templates con estructura optimizada por tipo de contenido.
  Triggers: "template contenido", "plantilla seo", "tipo de contenido", "crear template"
argument-hint: "[list | create nombre | apply nombre keyword]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-template — Templates de Contenido

Gestiona templates predefinidos por tipo de contenido con estructura SEO optimizada.

## Comandos

| Comando | Descripción |
|---|---|
| `template list` | Lista todos los templates disponibles |
| `template create [nombre]` | Crea un nuevo template interactivamente |
| `template apply [nombre] [keyword]` | Aplica un template para generar outline base |
| `template show [nombre]` | Muestra el detalle de un template |

## Templates predefinidos

| Template | Tipo de contenido | Estructura base |
|---|---|---|
| `how-to` | Guía paso a paso | Intro → Prerequisitos → Pasos → FAQ → Conclusión |
| `comparison` | Comparativa X vs Y | Intro → Resumen → Tabla comparativa → Análisis por criterio → Veredicto |
| `listicle` | Lista de N items | Intro → Item 1...N con subtítulos → Conclusión |
| `pillar` | Contenido pilar | Intro amplia → Secciones principales → Subtemas → FAQ extensa |
| `landing` | Landing page | Hero → Problema → Solución → Beneficios → Social proof → CTA |
| `local` | SEO local | Intro con ciudad/zona → Servicios locales → Por qué elegirnos → Zona de servicio → CTA |
| `review` | Reseña/Review | Resumen → Pros/Contras → Análisis detallado → Veredicto → Alternativas |
| `definition` | Definición/Glosario | Definición corta → Explicación extendida → Ejemplos → Relacionados |

## Ubicación de templates personalizados

`reports/{dominio}/templates/` — templates específicos del negocio
`~/.claude/skills/webmometro-seo-template/references/` — templates globales
