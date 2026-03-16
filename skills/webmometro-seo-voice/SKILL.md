---
name: webmometro-seo-voice
description: |
  Gestiona la voz de marca y voz del autor para un dominio.
  Define el tono, estilo y características de escritura para mantener consistencia en todo el contenido.
  Triggers: "brand voice", "voz de marca", "tono de escritura", "estilo editorial", "voz del autor"
argument-hint: "[show | create | update | apply] [dominio]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-voice — Brand Voice & Author Voice

Define y gestiona la voz de marca para mantener consistencia en todo el contenido SEO.

## Comandos

| Comando | Descripción |
|---|---|
| `voice show [dominio]` | Muestra la voz de marca actual |
| `voice create [dominio]` | Crea la voz de marca analizando contenido existente |
| `voice update [dominio]` | Actualiza la voz de marca |
| `voice apply [dominio] [texto]` | Reescribe un texto aplicando la voz de marca |

## Flujo `voice create [dominio]`

1. Lee contexto del negocio `reports/{dominio}/context.md`
2. Si existe contenido publicado: analiza 3-5 URLs del sitio con `mcp__dataforseo__onpage_task_post`
3. Infiere características de la voz actual
4. Genera borrador de la guía de voz
5. Pregunta al usuario: "¿Esto refleja cómo quieres que suene tu marca?"
6. Guarda en `reports/{dominio}/voice.md`

## Estructura de la guía de voz

```markdown
# Voz de Marca: {dominio}

## Tono general
{formal / conversacional / técnico / inspiracional / educativo}

## Características de escritura
- {rasgo 1}: {descripción y ejemplo}
- {rasgo 2}: {descripción y ejemplo}

## Vocabulario preferido
| Usar | Evitar |
|---|---|
| {palabra} | {palabra} |

## Estructura de oraciones
{longitud típica, uso de listas, encabezados, etc.}

## Voz del autor (si aplica)
{perspectiva, expertise, persona}

## Ejemplos de introducción
{bien}: {ejemplo}
{mal}: {ejemplo}
```
