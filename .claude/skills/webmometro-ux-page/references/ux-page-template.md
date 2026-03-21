---
title: Informe UX — {título o slug de la página}
url: {URL completa}
dominio: {dominio}
generado: {fecha}
actualizado: {fecha}
tags:
  - ux/page
  - cliente/{slug-cliente}
tipo: ux-page
---

# Informe UX — {título de la página}

**URL**: {URL completa}
**Generado**: {fecha} | **Período analizado**: últimos 30 días

---

## Ficha de la página

| Campo | Valor |
|---|---|
| URL | {URL} |
| Tipo de contenido | {artículo / landing / home / categoría / otro} |
| Objetivo de la página | {qué debe lograr esta página según el contexto del negocio} |
| Audiencia principal | {audiencia esperada según site-profile} |

---

## Observación visual del sitio

*Fuente: Chrome DevTools — captura directa del sitio al momento de la generación del informe*

### Menú de navegación

> [!info] Estructura del menú — capturada desde el DOM via Chrome DevTools
> La estructura y destinos son datos verificados del sitio. Los conteos de clics se completan desde dos fuentes:
> - **GA4**: poblar automáticamente si el evento `menu_click` está configurado. Si no, quedará vacío — GA4 por defecto solo registra clics en links externos.
> - **Clarity**: completar manualmente desde el heatmap (click map), filtrando por URL de esta página y dispositivo. No usar el MCP de Clarity para este dato — los textos de elementos son ambiguos cuando el mismo texto aparece en múltiples zonas de la página.

| Ítem | Destino | Desktop GA4 | Mobile GA4 | Desktop Clarity | Mobile Clarity |
|---|---|---|---|---|---|
| {texto} | {href} | | | | |

> [!note] Consistencia desktop/mobile
> {¿Los ítems y textos son idénticos en ambos dispositivos? Si hay diferencias, listarlas explícitamente. Si son iguales, confirmarlo en una línea.}

### CTAs principales

| Texto del botón o enlace | Zona de la página |
|---|---|
| {texto} | {hero / sección / footer} |

### Elementos interactivos vs decorativos

> [!note]
> {Lista de elementos que tienen interactividad declarada (cursor activo, enlace o acción asignada) versus elementos que visualmente parecen clicables pero no tienen ninguna acción. Permite validar o refutar los clics sin respuesta registrados por Clarity.}

---

## Resumen ejecutivo

> [!abstract] UX Page Score: {score}/100 — {estado}
> {1-2 líneas con el hallazgo más importante de esta página en términos de UX}

| Categoría | Puntuación | Estado |
|---|---|---|
| Frustración (salidas inmediatas, clics de frustración, clics sin respuesta) | {pts}/100 | {emoji} |
| Interacción y engagement (profundidad de scroll, duración, tasa de rebote) | {pts}/100 | {emoji} |
| Rendimiento técnico (CWV) | {pts}/100 | {emoji} |
| Diferencia mobile/desktop | {pts}/100 | {emoji} |
| **TOTAL** | **{score}/100** | **{emoji} {estado}** |

Rangos: 🟢 Excelente 85-100 / 🟡 Bueno 70-84 / 🟠 Necesita mejoras 50-69 / 🔴 Crítico 0-49

---

## 1. Comportamiento en Clarity

*Fuente: Microsoft Clarity — últimos 30 días*

| Métrica | Valor | Umbral | Estado | Interpretación |
|---|---|---|---|---|
| Salidas inmediatas (quick backs) | {%} | >40% = mismatch de contenido | {emoji} | {interpretación} |
| Profundidad de scroll (scroll depth) | {%} | <50% = estructura o contenido problemático | {emoji} | {interpretación} |
| Clics de frustración (rage clicks) | {%} | >5% = frustración activa | {emoji} | {interpretación} |
| Clics sin respuesta (dead clicks) | {%} | >10% = confusión de UX | {emoji} | {interpretación} |

> [!{tip|warning|danger}] Diagnóstico de comportamiento
> {hallazgo principal — ej: "Los usuarios hacen clics de frustración en el botón de descarga del informe, sugiriendo que el archivo no carga correctamente o la zona clicable es demasiado pequeña."}

---

## 2. Interacción y engagement en GA4

*Fuente: Google Analytics 4 — últimos 30 días*

### Por dispositivo

| Dispositivo | Sesiones | Tasa de rebote | Duración prom. | Páginas/sesión |
|---|---|---|---|---|
| Mobile | {n} | {%} | {mm:ss} | {n} |
| Desktop | {n} | {%} | {mm:ss} | {n} |
| Tablet | {n} | {%} | {mm:ss} | {n} |

### Nuevos vs recurrentes

| Tipo de usuario | Sesiones | Duración prom. |
|---|---|---|
| Nuevos | {n} | {mm:ss} |
| Recurrentes | {n} | {mm:ss} |

### Top fuentes de tráfico

| Canal | Sesiones | Tasa de rebote | Calidad |
|---|---|---|---|
| {canal} | {n} | {%} | {emoji} |
| {canal} | {n} | {%} | {emoji} |

> [!note] Interpretación de engagement
> {hallazgo clave — ej: "El tráfico orgánico tiene tasa de rebote del 25%, mientras el tráfico directo alcanza el 70%, lo que sugiere que los usuarios que llegan por búsqueda tienen una intención más clara que los que navegan directamente."}

---

## 3. Rendimiento técnico (Core Web Vitals — métricas de velocidad y estabilidad)

*Fuente: PageSpeed Insights*

| Métrica | Mobile | Desktop | Umbral óptimo |
|---|---|---|---|
| LCP — carga del elemento visual principal | {valor} | {valor} | ≤2.5s ✅ |
| CLS — estabilidad visual durante la carga | {valor} | {valor} | ≤0.1 ✅ |
| INP — velocidad de respuesta a interacciones | {valor} | {valor} | ≤200ms ✅ |
| FCP — aparición del primer contenido visible | {valor} | {valor} | ≤1.8s ✅ |
| TTFB — tiempo de respuesta inicial del servidor | {valor} | {valor} | ≤800ms ✅ |

**Puntuación PageSpeed**: Mobile {score}/100 · Desktop {score}/100

{Si hay top opportunity:}
> [!danger] Oportunidad principal de rendimiento
> {descripción de la optimización con mayor impacto estimado}

---

{Solo incluir esta sección si nav_analysis = true (página está en el TOP 5 del sitio)}

## 4. Navegación desde esta página

*Fuente: Microsoft Clarity — últimos 30 días*

> [!note] Metodología
> Clarity registra los textos de los elementos clicados en cada página y las páginas visitadas en la misma sesión. Los textos enmascarados (•••••) corresponden a datos que Clarity protege como información personal. Las "páginas destino" son URLs visitadas en sesiones que incluyeron esta página — no necesariamente por navegación directa.

**Elementos más clicados (desktop)**

| Elemento | Clics |
|---|---|
| {elemento} | {n} |

**Elementos más clicados (mobile)**

| Elemento | Clics |
|---|---|
| {elemento} | {n} |

**Páginas visitadas en la misma sesión**

| Destino | Sesiones Clarity | Sesiones GA4 | Tasa de rebote GA4 | Diagnóstico |
|---|---|---|---|---|
| {url} | {n} | {n} | {%} | {emoji + nota} |

> [!abstract] {hallazgo principal sobre cómo esta página distribuye la navegación}

---

## 5. Diferencia mobile/desktop

*Fuente: GA4 + PageSpeed Insights*

| Dimensión | Mobile | Desktop | Diferencia | Estado |
|---|---|---|---|---|
| Tasa de rebote | {%} | {%} | {+/- X pts} | {emoji} |
| Duración promedio | {mm:ss} | {mm:ss} | {+/- X%} | {emoji} |
| LCP — carga principal | {valor} | {valor} | {diferencia} | {emoji} |
| CLS — estabilidad visual | {valor} | {valor} | {diferencia} | {emoji} |

> [!{tip|warning|danger}] Diagnóstico mobile
> {hallazgo — ej: "La página presenta degradación significativa en mobile: tasa de rebote 35 puntos mayor que desktop y LCP 3x más lento. Prioridad: revisar imágenes sin optimización y layout de columnas en pantallas pequeñas."}

---

## 6. Hallazgos y recomendaciones

### Contenido

- **{hallazgo}** — {evidencia: ej "profundidad de scroll 30% sugiere que los usuarios no llegan al cuerpo del artículo"}
  → Recomendación: {acción concreta}

### Interacción

- **{hallazgo}** — {evidencia: ej "clics de frustración en zona del formulario"}
  → Recomendación: {acción concreta}

### Layout y diseño visual

- **{hallazgo}** — {evidencia}
  → Recomendación: {acción concreta}

### Rendimiento

- **{hallazgo}** — {evidencia: ej "LCP mobile 4.2s"}
  → Recomendación: {acción concreta}

---

## Plan de acción

### 🔴 Crítico — Resolver esta semana

- [ ] **{acción concreta}** — Impacto: {descripción}

### 🟠 Alto impacto — Este mes

- [ ] **{acción concreta}** — Impacto: {descripción}

### 🟡 Backlog — Próximo sprint

- [ ] **{acción concreta}**

---

## Notas de datos

- **Propiedad en Google Analytics 4 (GA4)**: {property_id} ({nombre de la propiedad})
- **Proyecto Clarity**: {nombre del MCP utilizado}
- **Período**: {fecha inicio} — {fecha fin}
- **Datos no disponibles**: {listar si aplica, o "Todos los MCPs respondieron correctamente"}

---

## Glosario

| Término | Significado |
|---|---|
| **Tasa de rebote** (bounce rate) | Porcentaje de visitas en que el usuario entra a la página y se va sin interactuar con ningún elemento. Una tasa alta puede indicar que el contenido no cumple la expectativa del visitante. |
| **Salidas inmediatas** (quick backs) | El usuario entra a la página y vuelve atrás en pocos segundos, antes de leer o interactuar con el contenido. Indica que lo que encontró no coincide con lo que esperaba. |
| **Clics sin respuesta** (dead clicks) | Clics sobre elementos que el usuario percibe como interactivos —imágenes, textos, bloques— pero que no tienen ninguna acción asignada. Generan frustración silenciosa. |
| **Clics de frustración** (rage clicks) | Clics repetidos y rápidos sobre un mismo elemento cuando no responde como se espera. Señal de que algo en el diseño o funcionamiento no está claro. |
| **Profundidad de scroll** (scroll depth) | Porcentaje de la página que los usuarios desplazan hacia abajo. Un valor bajo indica que el contenido del final de la página no está siendo visto. |
| **Interacción y engagement** | Nivel de participación activa del usuario con el contenido: cuánto tiempo permanece, cuántas páginas visita, si hace clic en elementos relevantes. |
| **LCP** | Largest Contentful Paint. Tiempo que tarda en cargarse el elemento visual principal de la página (generalmente una imagen o bloque de texto grande). Umbral recomendado: ≤2.5 segundos. |
| **CLS** | Cumulative Layout Shift. Mide la estabilidad visual durante la carga: si los elementos se mueven inesperadamente mientras la página aparece. Umbral recomendado: ≤0.1. |
| **INP** | Interaction to Next Paint. Velocidad con que la página responde visualmente cuando el usuario interactúa (hace clic, escribe). Umbral recomendado: ≤200ms. |
| **FCP** | First Contentful Paint. Tiempo hasta que aparece el primer contenido visible en pantalla. Umbral recomendado: ≤1.8 segundos. |
| **TTFB** | Time to First Byte. Tiempo que tarda el servidor en responder la primera solicitud del navegador. Umbral recomendado: ≤800ms. |
| **Core Web Vitals** | Conjunto de métricas definidas por Google para medir la experiencia técnica del usuario: velocidad de carga, estabilidad visual y capacidad de respuesta. |
| **Puntuación PageSpeed** | Calificación de 0 a 100 que otorga Google a una página según su velocidad y experiencia técnica. Se mide por separado para mobile y desktop. |
| **JavaScript** | Lenguaje de programación que controla la funcionalidad interactiva de una página web. Errores en este código pueden hacer que botones, formularios o animaciones fallen. |
| **Heatmap / Mapa de calor** | Visualización que muestra en qué zonas de una página hacen más clic los usuarios, usando colores (rojo = más clics, azul = menos). Ayuda a identificar qué elementos atraen más atención. |
| **GA4** | Google Analytics 4. Plataforma de analítica web de Google que registra el comportamiento de los visitantes: sesiones, dispositivos, fuentes de tráfico, duración y más. |
| **Microsoft Clarity** | Herramienta gratuita de analítica de comportamiento que registra mapas de calor, grabaciones de sesión y métricas de frustración como clics de frustración y clics sin respuesta. |
