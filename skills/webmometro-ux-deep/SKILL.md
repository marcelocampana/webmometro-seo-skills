---
name: webmometro-ux-deep
description: |
  Análisis UX profundo que combina los informes Webmómetro (ux-site, ux-page,
  site-profile) con materiales visuales adicionales aportados por el usuario
  (capturas de pantalla, exports de heatmaps, grabaciones procesadas, etc.).
  Actúa como experto UX senior que interpreta la evidencia, identifica el
  problema central de diseño y produce entregables accionables.
  Usar cuando el usuario mencione: "análisis ux profundo", "revisar el informe
  ux", "qué hacer con estos hallazgos", "recomendaciones de diseño", "cómo
  mejorar la experiencia", "wireframe", "propuesta de navegación", "rediseño",
  "profundizar en los hallazgos ux", "ux deep", "qué cambiamos primero",
  "traducir hallazgos a diseño", "backlog ux", "entregable ux", "propuesta
  para el cliente", "revisar estos datos de heatmap", "analizar esta captura",
  "qué rol juega esta página", "está cumpliendo su objetivo esta página",
  "vitrina vs distribuidor", "cómo mejorar la navegación", "qué cambia
  el diseñador", "análisis de diseño", "revisar la experiencia".
  El análisis se centra en una página específica (del informe ux-page).
  Los informes ux-site y site-profile actúan como contexto, no como objeto de análisis.
  Requiere los tres documentos previos. Si falta alguno, derivar primero.
  NO usar para generar datos de comportamiento — derivar a webmometro-ux-site
  o webmometro-ux-page. NO usar para auditoría SEO — derivar a
  webmometro-seo-page-audit.
metadata:
  version: 2.0.0
  argument-hint: "[dominio o URL] [materiales adicionales opcionales]"
---

# webmometro-ux-deep — Análisis UX Profundo

Análisis e interpretación UX de segunda capa. **El objeto de análisis es siempre una página específica** (del informe `ux-page`). Los informes `ux-site` y `site-profile` actúan como contexto: permiten entender si el comportamiento de la página es consistente con el sitio y si está cumpliendo su rol dentro de él.

Produce siempre un informe completo con: apertura narrativa, diagnóstico de diseño, wireframe textual, backlog UX, y conclusión. La propuesta de navegación y los perfiles de usuario se incluyen cuando los datos lo justifican.

## Estilo de escritura del informe

Los informes son leídos por equipos de marketing, comunicaciones y gestión de sitios web que entienden el negocio pero no necesariamente la jerga técnica de analítica, SEO o UX. Al redactar cualquier texto — callouts, párrafos de análisis, interpretaciones, recomendaciones — aplicar estas reglas:

1. **Aclarar términos técnicos cuando el contexto lo requiere.** El criterio no es "solo la primera vez en el informe", sino evaluar si el lector que llega directamente a esa sección entendería el término sin contexto previo. Si un término es central para comprender el hallazgo que se está explicando, aclararlo aunque ya haya aparecido antes. Si en esa sección ya fue explicado, no repetirlo.

2. **Siglas técnicas**: expandir en español cada vez que aparezcan en una sección nueva o en un contexto donde sean el dato principal del análisis:
   - LCP → "LCP (tiempo en cargar el elemento visual principal)"
   - CLS → "CLS (estabilidad visual durante la carga)"
   - INP → "INP (velocidad de respuesta a interacciones)"
   - FCP → "FCP (aparición del primer contenido visible)"
   - TTFB → "TTFB (tiempo de respuesta inicial del servidor)"

3. **Términos en inglés de comportamiento**: integrar la aclaración de forma natural cuando el término es clave para entender el análisis:
   - Bounce rate → "tasa de rebote (bounce rate)"
   - Dead clicks → "clics sin respuesta (dead clicks) — clics sobre elementos que parecen interactivos pero no hacen nada"
   - Rage clicks → "clics de frustración (rage clicks) — clics repetidos y rápidos cuando un elemento no responde"
   - Quick backs → "salidas inmediatas (quick backs) — el usuario entra a la página y vuelve atrás en pocos segundos"
   - Scroll depth → "profundidad de scroll — qué porcentaje de la página desplazan hacia abajo los usuarios"
   - Engagement → usar "nivel de interacción" o "interacción y engagement" en encabezados; en texto corrido integrar la aclaración cuando sea el concepto central del párrafo

4. **No saturar**: la aclaración debe sentirse natural, no mecánica. Si en un párrafo breve el mismo término aparece dos veces, aclarar solo una. El objetivo es que cualquier lector pueda entender el hallazgo sin tener que buscar definiciones externamente.

5. **Encabezados y títulos de tabla**: preferir el término en español directamente cuando el reemplazo es limpio. Los paréntesis son para texto corrido donde conviene conservar el término técnico como referencia.

**Tono**: consultor UX senior hablando con el equipo del cliente. Directo, basado en evidencia, sin rodeos. Las observaciones que van más allá de los datos son bienvenidas cuando la interpretación las justifica — señalar lo que los datos sugieren aunque no confirmen.

---

## Regla fundamental: scope y requisitos

**Este skill requiere los TRES documentos previos:**
- `ux-page` — **documento principal**: contiene los datos de comportamiento de la página que se analiza. Es el objeto central del análisis.
- `ux-site` — **contexto de sitio**: permite comparar el comportamiento de la página con el patrón general del sitio e identificar si los problemas son locales o sistémicos.
- `site-profile.md` — **contexto de negocio**: define el objetivo declarado de la página, las audiencias y la estrategia del sitio. Sin él, no es posible evaluar si la página cumple su función.

Si falta el `site-profile.md` → **detener y derivar sin continuar**:

> "Para ejecutar este análisis necesito el perfil del negocio, que no existe aún para `{dominio}`.
> Genera primero `/webmometro-seo-site-profile {dominio}` y vuelve aquí."

Si falta alguno de los informes UX → **detener y derivar sin continuar**:

> "Para ejecutar este análisis necesito ambos informes UX. Falta: `ux-{tipo}`.
> Genera primero `/webmometro-ux-{tipo} {dominio}` y vuelve aquí."

**NO** continuar con información incompleta, ni siquiera parcialmente.

---

## Configuración de ruta de reportes

Al iniciar, resolver la ruta base:
- Si `$SEO_REPORTS_PATH` está definida → usar ese valor como `REPORTS_DIR`
- Si no → usar `{cwd}/reports` y advertir al usuario

---

## Control de frescura del reporte

Antes de iniciar, verificar si ya existe un reporte para este dominio:

```
$SEO_REPORTS_PATH/{dominio}/ux/ux-deep-*.md
```

Si existe un reporte con **menos de 15 días** desde hoy:

> "Ya existe un análisis UX profundo de `{dominio}` generado el {fecha} ({N} días). ¿Qué quieres hacer?
>
> **R** — Regenerar el análisis completo
> **C** — Cancelar
>
> O indica el número de la sección que quieres actualizar:
> 1. Apertura y diagnóstico de diseño
> 2. Wireframe textual
> 3. Backlog UX
> 4. Propuesta de navegación
> 5. Perfiles de usuario
> 6. Conclusión"

Si el usuario responde con números, ejecutar solo los pasos necesarios y actualizar esas secciones. Si el reporte tiene **15 días o más**, o no existe → ejecutar el flujo completo.

---

## Flujo de ejecución

### Paso 0 — Inventario de materiales

1. Verificar existencia de los tres documentos requeridos (en este orden):
   - `$SEO_REPORTS_PATH/{dominio}/site-profile.md` — si no existe → detener y derivar a `/webmometro-seo-site-profile`
   - `$SEO_REPORTS_PATH/{dominio}/ux/ux-site-*.md` — el más reciente; si no existe → detener y derivar a `/webmometro-ux-site`
   - `$SEO_REPORTS_PATH/{dominio}/ux/ux-page-*.md` — todos los disponibles; si no existe ninguno → detener y derivar a `/webmometro-ux-page`

2. Verificar antigüedad de cada documento. Leer la fecha desde el frontmatter (`generado:`) o desde el nombre del archivo. Comparar con la fecha de hoy:
   - Si cualquiera de los tres tiene **más de 30 días** → advertir antes de continuar:

   > "⚠️ Uno o más documentos base tienen más de un mes de antigüedad:
   >
   > - `site-profile.md` — generado el {fecha} ({N} días) {si aplica}
   > - `ux-site-{fecha}.md` — generado el {fecha} ({N} días) {si aplica}
   > - `ux-page-{slug}-{fecha}.md` — generado el {fecha} ({N} días) {si aplica}
   >
   > El análisis puede no reflejar el estado actual del sitio. ¿Quieres continuar de todas formas o regenerar primero los documentos desactualizados?"

   Esperar respuesta del usuario. Si confirma continuar → proceder. Si quiere regenerar → derivar al skill correspondiente y detener.

3. Leer los tres documentos confirmados:
   - `$SEO_REPORTS_PATH/{dominio}/site-profile.md`
   - `$SEO_REPORTS_PATH/{dominio}/ux/ux-site-*.md`
   - `$SEO_REPORTS_PATH/{dominio}/ux/ux-page-*.md`

4. Buscar materiales adicionales en la carpeta de assets del dominio:
   - `$SEO_REPORTS_PATH/{dominio}/ux/assets/` — leer todo lo que haya: imágenes (capturas, heatmaps), PDFs, CSVs
   - Si la carpeta no existe o está vacía → no es error, simplemente no hay materiales en disco

5. Identificar materiales adicionales aportados por el usuario en la conversación:
   - Capturas de pantalla (imágenes adjuntas al mensaje)
   - Exports de heatmaps (ZIP, CSV, imágenes de Clarity, Hotjar, Crazy Egg)
   - Cualquier otro documento adjunto (PDFs, briefs, guías de marca)

6. Presentar inventario explícito al usuario, combinando ambas fuentes:

> "Encontré los siguientes materiales para `{dominio}`:
>
> ✅ site-profile.md (actualizado {fecha})
> ✅ ux-site-{fecha}.md
> ✅ ux-page-{slug}-{fecha}.md
>
> Materiales adicionales:
> ✅ assets/{archivo} — {descripción breve del tipo}   ← si los hay en disco
> ✅ {archivo adjunto en conversación}                 ← si los hay en el mensaje
> _(ninguno)_                                          ← si no hay ninguno
>
> ¿Quieres agregar algo más antes de comenzar — capturas de pantalla, exports de heatmaps u otro material?"

Si el usuario no aporta nada adicional → continuar con lo disponible.

---

### Paso 0.5 — Pregunta abierta de orientación

Antes de analizar, preguntar:

> "¿Hay algo específico que quieras explorar, alguna hipótesis que quieras que evalúe, o alguna pregunta que guíe el análisis?
> (Puedes responder libremente o continuar sin orientación adicional.)"

Esta respuesta se usa para enfocar el análisis. Si el usuario no responde o dice "no" → continuar sin sesgo particular.

---

### Paso 1 — Análisis integrado (interno)

Ejecutar internamente antes de generar cualquier output. No mostrar este paso al usuario.

**Desde los informes Webmómetro:**

*Fuente principal — ux-page:*
- Extraer todos los hallazgos 🔴 y 🟠 del plan de acción de la página
- Leer datos cuantitativos: tasa de rebote, profundidad de scroll, dead clicks, rage clicks, salidas inmediatas, tiempo en página, diferencias mobile/desktop
- Identificar qué elementos específicos generan fricción en esta página

*Contexto de sitio — ux-site:*
- Comparar los indicadores de la página con los promedios del sitio
- Identificar si los problemas son exclusivos de esta página o se repiten en otras
- Leer patrones de navegación: ¿de dónde llegan a esta página y hacia dónde van?

*Contexto de negocio — site-profile:*
- Leer el objetivo declarado de esta página y las audiencias que la usan
- Entender el rol esperado de la página dentro del sitio

**Desde materiales visuales (si existen):**
- Capturas de pantalla: evaluar jerarquía visual percibida, affordances, densidad, qué parece clickeable vs qué es clickeable realmente, consistencia entre dispositivos
- Exports de heatmaps: leer clics por zona, elementos con dead clicks, patrones de scroll visual, comparar desktop vs mobile
- Cruzar con datos cuantitativos — ¿los números y lo visual se confirman mutuamente o se contradicen?

**Evaluación contra principios de diseño (interno):**

Leer `references/rules/` y aplicar como criterio de evaluación — no como contenido a citar en el informe:

- Desde `references/rules/information-architecture.md`: ¿Los labels de navegación responden al vocabulario del usuario o a la estructura interna del negocio? ¿La jerarquía de contenido sigue el orden de las metas del usuario? ¿Hay information scent suficiente en los elementos interactivos?

- Desde `references/rules/interaction-design.md`: ¿Hay dead ends en los flujos que los datos revelan? ¿Los CTAs usan verbos genéricos (Submit, OK) en lugar de específicos? ¿Hay evidencia de formularios que no preservan datos en error?

- Desde `references/rules/visual-design.md`: ¿La jerarquía visual real de la página coincide con la jerarquía de intención del usuario? ¿Hay CTAs de peso visual equivalente compitiendo entre sí? ¿El contenido de mayor valor está en zonas de alta visibilidad (F-pattern / Z-pattern)?

- Desde `references/rules/accessibility.md`: ¿Los datos de Clarity sugieren problemas de touch targets (rage clicks concentrados en zonas pequeñas)? ¿Hay indicios de problemas de contraste o interactividad que no funciona con teclado?

**Síntesis interna (responder antes de generar output):**
- ¿Qué objetivo tiene esta página según el site-profile? ¿Los datos del ux-page indican que se cumple?
- ¿El comportamiento de esta página es consistente con el patrón general del sitio, o es un caso particular?
- ¿Qué rol funcional está cumpliendo realmente la página? (distribuidor / vitrina / conversor / informador / punto de entrada)
- ¿Hay brecha entre el rol actual y el esperado?
- ¿Cuál es la causa raíz de diseño — no los síntomas?
- ¿Qué patrones aparecen en múltiples fuentes simultáneamente?
- ¿Qué no se está midiendo pero los datos sugieren que importa?

---

### Paso 2 — Apertura narrativa (siempre, al inicio del output)

Escribir 3-4 párrafos que integren en prosa la lectura de conjunto. No usar títulos de sección para estos párrafos — fluyen directamente después del encabezado del informe.

**Párrafo 1 — Contexto y veredicto:** Qué objetivo tiene esta página según el site-profile y qué dicen los datos del ux-page sobre si se cumple. No listar métricas — eso ya está en ux-page. Ir directo a la interpretación.

**Párrafo 2 — Rol funcional real:** Qué está haciendo realmente la página, nombrado en términos de rol (distribuidor / vitrina / conversor / informador / punto de entrada). Si hay brecha con el rol esperado, describirla en una frase concreta. Comparar con el patrón del sitio desde ux-site: ¿es un problema local o sistémico?

**Párrafo 3 — Causa raíz de diseño:** La causa que explica los hallazgos del ux-page, nombrada con el lenguaje de los principios de diseño. No es un síntoma ("bounce rate alto"). Es la causa que lo genera ("ausencia de jerarquía visual que dirija al usuario hacia la acción principal" o "falta de information scent en los elementos de navegación"). Usar los criterios internalizados de `references/rules/` para nombrar la causa con precisión.

**Párrafo 4 — Hipótesis sin confirmar (opcional):** Si durante el análisis interno surgió una hipótesis que los datos sugieren pero no confirman, articularla brevemente. Omitir si no hay nada genuinamente nuevo que agregar.

Seguido de la tabla de estado por dimensión (sin encabezado de sección propio):

| Dimensión | Estado | Evidencia clave |
|---|---|---|
| Arquitectura de información | {emoji} | {dato concreto} |
| Affordances e interacción | {emoji} | {dato concreto} |
| Jerarquía visual | {emoji} | {dato concreto} |
| Experiencia mobile | {emoji} | {dato concreto} |
| Accesibilidad | {emoji} | {dato o "sin datos suficientes"} |

Rangos: 🟢 Sin problemas / 🟡 Oportunidad de mejora / 🟠 Problema identificado / 🔴 Crítico

---

### Paso 3 — Diagnóstico de diseño (siempre)

**Regla crítica:** NO repetir datos que ya están en ux-page. El lector tiene ambos informes. El diagnóstico arranca donde ux-page termina: ux-page describió los síntomas con sus datos; este paso interpreta las causas de diseño que los generan.

Formato por causa:

```
**[Nombre descriptivo de la causa — no el síntoma]**
Evidencia: {dato del ux-page que la sustenta}
Problema de diseño: {principio violado, con lenguaje de las reglas}
Impacto: {comportamiento del usuario que esto genera}
```

Límite: 3-5 causas, ordenadas por evidencia (la más sustentada primero). Si hay más causas posibles pero con menor evidencia, mencionarlas brevemente al final de la sección.

Aplicar durante la redacción:
- `references/rules/information-architecture.md` → causas relacionadas con navegación, labels, jerarquía de contenido, information scent
- `references/rules/interaction-design.md` → causas relacionadas con flows, affordances, microcopy, dead ends
- `references/rules/visual-design.md` → causas relacionadas con jerarquía visual, CTAs en competencia, F-pattern, whitespace
- `references/rules/accessibility.md` → causas relacionadas con touch targets, contraste, interactividad

Cerrar la sección con:
- **Prioridades de intervención**: qué causa atender primero y por qué, en lista numerada con una línea de justificación por ítem
- **Limitaciones del análisis**: inconsistencias entre fuentes, hipótesis sin confirmar, datos que faltan; si todo es consistente, indicarlo en una línea

---

### Paso 4 — Wireframe textual (siempre)

El wireframe es el entregable más accionable para el equipo de diseño. Siempre se genera.

Antes de escribir, definir internamente:
- ¿Cuál es la página o flujo a wireframear? (la página del informe ux-page, salvo que el diagnóstico revele que el problema está en un flujo entre páginas)
- ¿Cuál es el objetivo de la página según el site-profile?
- ¿Cuál es la causa raíz identificada en el Paso 3?

El wireframe no rediseña arbitrariamente — resuelve las causas identificadas. Cada bloque existe porque resuelve una causa específica del diagnóstico.

Abrir con una línea que explica qué problema de diseño resuelve el wireframe (referencia directa a la causa raíz del Paso 3).

Formato por bloque:

```
**[Nombre del bloque]**
Contenido: {qué va aquí — concreto, no genérico}
Por qué: {qué causa del diagnóstico resuelve este bloque}
Principio: {principio de diseño aplicado, nombrado desde las reglas}
Nota mobile: {cómo se adapta o variante — solo si es relevante}
```

Cerrar con una sección "Principios aplicados" con 2-4 principios de diseño y una línea explicando cómo se aplicó cada uno en este wireframe específico.

Aplicar durante la redacción:
- `references/rules/visual-design.md` → jerarquía, F-pattern, CTA principal sin competencia, whitespace, una acción dominante por pantalla
- `references/rules/interaction-design.md` → flows sin dead ends, microcopy de CTAs con verbos específicos, feedback después de acciones
- `references/rules/information-architecture.md` → orden de contenido por goals del usuario, labels en vocabulario del usuario
- `references/rules/accessibility.md` → touch targets ≥44px, contraste en elementos interactivos, focus visible

---

### Paso 5 — Backlog UX (siempre)

Consolidar todos los cambios identificados en el diagnóstico y en el wireframe en una tabla priorizada.

El backlog no es un resumen — es una herramienta de trabajo. Cada ítem debe ser suficientemente concreto para que alguien pueda ejecutarlo sin leer el resto del informe.

| Hallazgo | Página | Cambio propuesto | Impacto | Esfuerzo | Prioridad |
|---|---|---|---|---|---|
| {hallazgo} | {url} | {cambio concreto} | Alto/Medio/Bajo | Alto/Medio/Bajo | 🔴/🟠/🟡 |

Criterio de prioridad:
- 🔴 Crítico: impacto alto + esfuerzo bajo/medio
- 🟠 Alto: impacto alto + esfuerzo alto, o impacto medio + esfuerzo bajo
- 🟡 Backlog: impacto medio/bajo

Ordenar por prioridad descendente (🔴 primero). Límite: entre 5 y 15 ítems.

---

### Paso 6 — Propuesta de navegación (condicional)

Incluir esta sección si al menos una condición aplica:
- (a) El diagnóstico identificó problemas de information scent en la navegación
- (b) El ux-site muestra patrones de desorientación de navegación (muchas páginas visitadas por sesión con salidas desde páginas inesperadas)
- (c) El usuario mencionó explícitamente la navegación en la pregunta de orientación (Paso 0.5)
- (d) El wireframe propone una reorganización que implica cambios en el menú

Si ninguna condición aplica: omitir la sección sin mencionarlo.

Estructura:
- Diagnóstico del menú actual: qué labels tienen bajo information scent, cuáles responden a estructura interna en lugar de al vocabulario del usuario
- Tabla: label actual → label recomendado → por qué
- Árbol de navegación propuesto (desktop y mobile unificados; diferencias justificadas si las hay)
- Principios aplicados: information scent, vocabulario del usuario, límite de ítems, consistencia

Aplicar: `references/rules/information-architecture.md` como regla principal de esta sección.

---

### Paso 7 — Perfiles de usuario (condicional)

Incluir si el análisis revela segmentos claramente diferenciados: al menos dos comportamientos distintos cruzando device + canal de entrada + patrones de frustración desde GA4 y Clarity.

Si no hay evidencia suficiente: omitir la sección e indicarlo brevemente en "Notas de análisis".

Generar 1-2 perfiles usando el template de `references/rules/research.md`:
- **Nombre** descriptivo basado en comportamiento observado, no inventado
- **Comportamiento observado**: device predominante, canal de entrada, páginas que más visita
- **Lo que busca**: goals inferidos desde las páginas que más retienen
- **Dónde se frustra**: pain points directamente desde datos de frustración (Clarity + GA4)
- **Patrón de navegación**: cómo entra, qué recorre, dónde sale
- **Quote** que capture el patrón central observado en los datos

---

### Paso 8 — Conclusión (siempre)

Siempre presente. Cierra el informe con una lectura de conjunto.

**Contenido:** Integra diagnóstico, wireframe y backlog en una sola idea — no repite hallazgos individuales sino el patrón que los conecta. Puede incluir: tensiones entre fuentes (cuando los datos cuantitativos y la evidencia visual apuntan en direcciones distintas), hipótesis sin confirmar que merecen atención, o lo que no se está midiendo pero los datos sugieren que importa.

**Tono:** Neutro, sin primera persona. Voz de análisis experto.

**Cierre obligatorio:** Un párrafo final que sintetiza el cambio más importante y el impacto esperado — formulado de modo que el equipo pueda citarlo en una reunión sin necesidad de releer el informe.

---

### Paso 9 — Guardar output

Guardar en: `$SEO_REPORTS_PATH/{dominio}/ux/ux-deep-{fecha}.md`

Si el usuario actualizó solo secciones específicas (flujo de frescura), guardar en el mismo archivo existente reemplazando únicamente las secciones actualizadas.

---

## Política de errores

Si algún informe requerido no puede leerse o está vacío → registrar el problema, no continuar con datos incompletos. Informar al usuario qué falta y cómo generarlo.

---

## Template del informe

Ver [references/ux-deep-template.md](references/ux-deep-template.md)

## Reglas de diseño UX disponibles en references/rules/

| Dimensión | Archivo | Cuándo leer |
|---|---|---|
| Navegación y labels | `references/rules/information-architecture.md` | Paso 1, 3, 4, 6 |
| Affordances y flows | `references/rules/interaction-design.md` | Paso 1, 3, 4 |
| Jerarquía visual | `references/rules/visual-design.md` | Paso 1, 3, 4 |
| Accesibilidad | `references/rules/accessibility.md` | Paso 1, 3, 4 |
| Perfiles de usuario | `references/rules/research.md` | Paso 7 |
