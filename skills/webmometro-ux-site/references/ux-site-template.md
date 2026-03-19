---
title: Informe UX — {dominio}
dominio: {dominio}
generado: {fecha}
actualizado: {fecha}
tags:
  - ux/site
  - cliente/{slug-cliente}
tipo: ux-site
---

# Informe UX — {dominio}

**Generado**: {fecha} | **Período analizado**: últimos 30 días

---

## Resumen ejecutivo

> [!abstract] UX Health Score (puntuación general de experiencia): {score}/100 — {estado}
> {1-2 líneas con el hallazgo más importante del sitio en términos de UX}

| Categoría | Puntuación | Estado |
|---|---|---|
| Frustración (clics sin respuesta, salidas inmediatas, clics de frustración) | {pts}/100 | {emoji} |
| Interacción y engagement (scroll, duración, tasa de rebote) | {pts}/100 | {emoji} |
| Rendimiento técnico (CWV) | {pts}/100 | {emoji} |
| Diferencia mobile/desktop | {pts}/100 | {emoji} |
| Errores JavaScript | {pts}/100 | {emoji} |
| **TOTAL** | **{score}/100** | **{emoji} {estado}** |

Rangos: 🟢 Excelente 85-100 / 🟡 Bueno 70-84 / 🟠 Necesita mejoras 50-69 / 🔴 Crítico 0-49

---

## 1. Audiencia y dispositivos

*Fuente: Google Analytics 4 — últimos 30 días*

### Por dispositivo

| Dispositivo | Sesiones | % del total | Tasa de rebote | Duración prom. |
|---|---|---|---|---|
| Mobile | {n} | {%} | {%} | {mm:ss} |
| Desktop | {n} | {%} | {%} | {mm:ss} |
| Tablet | {n} | {%} | {%} | {mm:ss} |

### Nuevos vs recurrentes

| Tipo de usuario | Sesiones | Tasa de rebote | Duración prom. |
|---|---|---|---|
| Nuevos | {n} | {%} | {mm:ss} |
| Recurrentes | {n} | {%} | {mm:ss} |

> [!note] Interpretación
> {hallazgo clave sobre dispositivos y tipo de usuario — ej: "El mobile representa el X% del tráfico pero tiene una tasa de rebote X% mayor que desktop, señal de problemas de experiencia en pantallas pequeñas."}

---

## 2. Páginas con mayor frustración

*Fuente: Microsoft Clarity — últimos 30 días*

> [!warning] Páginas con señales de frustración activa
> Ordenadas de mayor a menor nivel de frustración combinado.

| Página | Salidas inmediatas | Clics de frustración | Clics sin respuesta | Nivel |
|---|---|---|---|---|
| {url} | {%} | {%} | {%} | 🔴 Alto |
| {url} | {%} | {%} | {%} | 🟠 Medio |
| {url} | {%} | {%} | {%} | 🟡 Bajo |

**Umbrales**: Salidas inmediatas >40% 🔴 / Clics de frustración >5% 🔴 / Clics sin respuesta >10% 🟠

---

## 3. Interacción y engagement por página

*Fuente: GA4 + Microsoft Clarity — últimos 30 días*

### Páginas estrella (alto engagement)

| Página | Sesiones | Tasa de rebote | Duración prom. | Profundidad de scroll |
|---|---|---|---|---|
| {url} | {n} | {%} | {mm:ss} | {%} |

### Páginas problema (bajo engagement)

| Página | Sesiones | Tasa de rebote | Duración prom. | Salidas inmediatas |
|---|---|---|---|---|
| {url} | {n} | {%} | {mm:ss} | {%} |

### Páginas con potencial (tráfico alto, engagement medio)

| Página | Sesiones | Tasa de rebote | Oportunidad |
|---|---|---|---|
| {url} | {n} | {%} | {descripción breve} |

---

## 4. Flujos de navegación y puntos de salida

*Fuente: Google Analytics 4 — últimos 30 días*

### Calidad por canal de entrada

| Canal | Sesiones | Tasa de rebote | Duración prom. | Calidad |
|---|---|---|---|---|
| {canal} | {n} | {%} | {mm:ss} | {emoji} |

### Top páginas de salida

| Página | Salidas | % salidas | Acción sugerida |
|---|---|---|---|
| {url} | {n} | {%} | {acción} |

> [!tip] Hallazgo de navegación
> {insight sobre dónde se pierden los usuarios y por qué}

---

## 5. Navegación desde páginas distribuidoras

*Fuente: Microsoft Clarity — últimos 30 días*

> [!note] Metodología
> Clarity registra los textos de los elementos clicados en cada página y las páginas visitadas en la misma sesión. Los textos enmascarados (•••••) corresponden a datos que Clarity protege como información personal. Las "páginas destino" son URLs visitadas en sesiones que incluyeron la página analizada — no necesariamente por navegación directa desde esa página.

{Para cada una de las top 5 páginas por sesiones:}

### {URL página} — {n} sesiones GA4

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

### Síntesis de navegación interna

> [!abstract] {hallazgo principal sobre la arquitectura de navegación}

| Hallazgo | Páginas afectadas | Prioridad |
|---|---|---|
| {hallazgo} | {páginas} | {emoji} |

---

## 6. Rendimiento técnico (Core Web Vitals — métricas de velocidad y estabilidad)

*Fuente: PageSpeed Insights — homepage*

| Métrica | Mobile | Desktop | Umbral |
|---|---|---|---|
| LCP — carga del elemento visual principal | {valor} | {valor} | ≤2.5s ✅ |
| CLS — estabilidad visual durante la carga | {valor} | {valor} | ≤0.1 ✅ |
| INP — velocidad de respuesta a interacciones | {valor} | {valor} | ≤200ms ✅ |
| FCP — aparición del primer contenido visible | {valor} | {valor} | ≤1.8s ✅ |
| TTFB — tiempo de respuesta inicial del servidor | {valor} | {valor} | ≤800ms ✅ |

**Puntuación PageSpeed**: Mobile {score}/100 · Desktop {score}/100

> [!danger] Oportunidad principal de rendimiento
> {top opportunity detectado por PageSpeed, si existe}

---

## 7. Errores JavaScript (errores de código que afectan la funcionalidad)

*Fuente: Microsoft Clarity — últimos 30 días*

| Error | Frecuencia | Páginas afectadas |
|---|---|---|
| {descripción del error} | {n} veces | {páginas} |

{Si no hay errores: "> ✅ No se detectaron errores JavaScript en el período analizado."}

---

## 8. Plan de acción

### 🔴 Crítico — Resolver esta semana

- [ ] **{acción concreta}** — {página o área afectada} · Impacto: {descripción}
- [ ] **{acción concreta}** — {página o área afectada} · Impacto: {descripción}

### 🟠 Alto impacto — Este mes

- [ ] **{acción concreta}** — {página o área afectada} · Impacto: {descripción}
- [ ] **{acción concreta}** — {página o área afectada} · Impacto: {descripción}

### 🟡 Backlog — Próximo sprint

- [ ] **{acción concreta}** — {página o área afectada}
- [ ] **{acción concreta}** — {página o área afectada}

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
| **Tasa de rebote** (bounce rate) | Porcentaje de visitas en que el usuario entra al sitio y se va sin interactuar con ningún elemento. Una tasa alta puede indicar que el contenido no cumple la expectativa del visitante. |
| **Salidas inmediatas** (quick backs) | El usuario entra a una página y vuelve atrás en pocos segundos, antes de leer o interactuar con el contenido. Indica que lo que encontró no coincide con lo que esperaba. |
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
| **Microsoft Clarity** | Herramienta gratuita de analítica de comportamiento que registra mapas de calor, grabaciones de sesión y métricas de frustración como rage clicks y dead clicks. |
