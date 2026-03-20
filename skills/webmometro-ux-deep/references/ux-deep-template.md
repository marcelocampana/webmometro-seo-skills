---
title: Análisis UX Profundo — {dominio}
dominio: {dominio}
pagina_analizada: {URL de la página del informe ux-page}
generado: {fecha}
fuentes:
  - {ux-site-fecha.md}
  - {ux-page-slug-fecha.md}
  - {materiales adicionales si los hay}
tags:
  - ux/deep
  - cliente/{slug-cliente}
tipo: ux-deep
---

# Análisis UX Profundo — {dominio}

**Página analizada**: {URL} | **Generado**: {fecha} | **Período de referencia**: {período de los informes base}

**Materiales utilizados**: {lista de fuentes — informes + materiales adicionales}

---

{Párrafo 1: qué objetivo tiene esta página según el site-profile y qué dicen los datos del ux-page sobre si se cumple. No listar métricas — eso ya está en ux-page. Ir directo a la interpretación: ¿los datos confirman que la página cumple su función, o revelan una brecha?}

{Párrafo 2: qué está haciendo realmente la página, nombrado en términos de rol (distribuidor / vitrina / conversor / informador / punto de entrada). Si hay brecha con el rol esperado, describirla en una frase concreta. Comparar con el patrón del sitio desde ux-site: ¿es un problema local o sistémico?}

{Párrafo 3: la causa raíz de diseño que explica los hallazgos del ux-page. No es un síntoma — es la causa que lo genera, nombrada con el lenguaje de los principios de diseño. Ej: "ausencia de jerarquía visual que dirija al usuario hacia la acción principal", no "bounce rate alto".}

{Párrafo 4 — opcional: hipótesis que los datos sugieren pero no confirman. Omitir si no hay nada genuinamente nuevo que agregar.}

| Dimensión | Estado | Evidencia clave |
|---|---|---|
| Arquitectura de información | {emoji} | {dato concreto} |
| Affordances e interacción | {emoji} | {dato concreto} |
| Jerarquía visual | {emoji} | {dato concreto} |
| Experiencia mobile | {emoji} | {dato concreto} |
| Accesibilidad | {emoji} | {dato o "sin datos suficientes"} |

🟢 Sin problemas / 🟡 Oportunidad de mejora / 🟠 Problema identificado / 🔴 Crítico

---

## Diagnóstico de diseño

### Causas identificadas

**[{Causa 1 — nombre descriptivo del problema de diseño}]**
Evidencia: {dato del ux-page que la sustenta}
Problema de diseño: {principio de diseño violado, en lenguaje de las reglas}
Impacto: {comportamiento del usuario que esto genera}

**[{Causa 2}]**
Evidencia: {dato}
Problema de diseño: {principio violado}
Impacto: {comportamiento resultante}

**[{Causa 3}]**
Evidencia: {dato}
Problema de diseño: {principio violado}
Impacto: {comportamiento resultante}

### Prioridades de intervención

{Qué causa atender primero y por qué. Criterio: impacto en el objetivo de la página combinado con factibilidad. Lista numerada con una línea de justificación por ítem.}

> [!note] Limitaciones del análisis
> {Inconsistencias entre fuentes, hipótesis sin confirmar, datos que faltan. Si todo es consistente, indicarlo en una sola línea.}

---

## Wireframe — {nombre de la página o flujo}

_{Qué problema de diseño resuelve este wireframe, en una línea. Referencia directa a la causa raíz del diagnóstico.}_

**[{Nombre del bloque 1}]**
Contenido: {qué va aquí — concreto, no genérico}
Por qué: {qué causa del diagnóstico resuelve este bloque}
Principio: {principio de diseño aplicado, nombrado desde las reglas}

**[{Nombre del bloque 2}]**
Contenido: {qué va aquí}
Por qué: {qué causa resuelve}
Principio: {principio aplicado}
Nota mobile: {cómo se adapta o variante — solo si es relevante}

**[{Nombre del bloque 3}]**
Contenido: {qué va aquí}
Por qué: {qué causa resuelve}
Principio: {principio aplicado}

{...continuar con todos los bloques necesarios}

### Principios aplicados

- **{Principio 1}**: {cómo se aplicó en este wireframe}
- **{Principio 2}**: {cómo se aplicó}
- **{Principio 3}**: {cómo se aplicó}

---

## Backlog UX

| Hallazgo | Página | Cambio propuesto | Impacto | Esfuerzo | Prioridad |
|---|---|---|---|---|---|
| {hallazgo} | {url} | {cambio concreto — accionable sin leer el resto del informe} | Alto/Medio/Bajo | Alto/Medio/Bajo | 🔴/🟠/🟡 |

> [!note] Criterio de prioridad
> 🔴 Crítico — impacto alto + esfuerzo bajo/medio
> 🟠 Alto — impacto alto + esfuerzo alto, o impacto medio + esfuerzo bajo
> 🟡 Backlog — impacto medio/bajo

---

{Incluir esta sección solo si al menos una condición aplica: (a) diagnóstico identificó problemas de information scent en la navegación, (b) ux-site muestra desorientación de navegación, (c) usuario lo mencionó en la pregunta de orientación, (d) el wireframe implica cambios en el menú. Si ninguna aplica, omitir sin mencionar que se omitió.}

## Propuesta de navegación

> [!warning] Problemas de señal informacional (information scent)
> {Qué labels generan confusión y por qué — qué responde a estructura interna en lugar de al vocabulario del usuario.}

| Label actual | Label recomendado | Por qué |
|---|---|---|
| {texto actual} | {texto propuesto} | {razón en una línea} |

### Árbol de navegación propuesto

```
{Estructura de menú en texto, desktop y mobile unificados. Si hay diferencias justificadas, indicarlas.}
```

### Principios aplicados

{Information scent, vocabulario del usuario vs vocabulario institucional, límite 5-7 ítems, consistencia desktop/mobile.}

---

{Incluir esta sección solo si los datos muestran al menos dos comportamientos diferenciados claramente (device + canal + patrones de frustración). Si no hay evidencia suficiente, omitir e indicarlo en "Notas de análisis".}

## Perfiles de usuario

### {Nombre del perfil — basado en comportamiento observado, no inventado}

**Comportamiento observado**: {device predominante, canal de entrada, páginas que más visita}
**Lo que busca**: {goals inferidos desde las páginas que más retienen}
**Dónde se frustra**: {pain points desde datos de frustración — Clarity + GA4}
**Patrón de navegación**: {cómo entra, qué recorre, dónde sale}

> "{Quote que capture el patrón central observado en los datos}"

---

## Conclusión

{Lectura de conjunto que integra diagnóstico, wireframe y backlog en una sola idea — no repite hallazgos individuales sino el patrón que los conecta. Puede incluir: tensiones entre fuentes (cuando los datos cuantitativos y la evidencia visual apuntan en direcciones distintas), hipótesis sin confirmar que merecen atención, o lo que no se está midiendo pero los datos sugieren que importa.

Tono neutro, sin primera persona. Voz de análisis experto, no de participante.

Cierre obligatorio en párrafo separado: una frase que sintetiza el cambio más importante y el impacto esperado — formulada de modo que el equipo pueda citarla en una reunión sin necesidad de releer el informe.}

---

## Notas de análisis

- **Informes base**: {lista de archivos utilizados con fechas}
- **Materiales adicionales**: {lista o "ninguno"}
- **Hipótesis no confirmadas**: {si las hay, o "ninguna"}
- **Datos no disponibles**: {qué faltó y qué habría aportado, o "todos los MCPs respondieron correctamente"}
