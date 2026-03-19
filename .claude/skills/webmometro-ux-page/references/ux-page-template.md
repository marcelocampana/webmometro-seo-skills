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

## Resumen ejecutivo

> [!abstract] UX Page Score: {score}/100 — {estado}
> {1-2 líneas con el hallazgo más importante de esta página en términos de UX}

| Categoría | Puntuación | Estado |
|---|---|---|
| Frustración (rage/dead clicks, quick backs) | {pts}/100 | {emoji} |
| Engagement (scroll depth, duración, bounce) | {pts}/100 | {emoji} |
| Performance CWV | {pts}/100 | {emoji} |
| Paridad mobile/desktop | {pts}/100 | {emoji} |
| **TOTAL** | **{score}/100** | **{emoji} {estado}** |

Rangos: 🟢 Excelente 85-100 / 🟡 Bueno 70-84 / 🟠 Necesita mejoras 50-69 / 🔴 Crítico 0-49

---

## 1. Comportamiento en Clarity

*Fuente: Microsoft Clarity — últimos 30 días*

| Métrica | Valor | Umbral | Estado | Interpretación |
|---|---|---|---|---|
| Quick backs | {%} | >40% = problema | {emoji} | {interpretación} |
| Scroll depth | {%} | <50% = problema | {emoji} | {interpretación} |
| Rage clicks | {%} | >5% = frustración | {emoji} | {interpretación} |
| Dead clicks | {%} | >10% = confusión | {emoji} | {interpretación} |

> [!{tip|warning|danger}] Diagnóstico de comportamiento
> {hallazgo principal — ej: "Los usuarios hacen rage click en el botón de descarga del informe, sugiriendo que el archivo no carga correctamente o la zona clickeable es demasiado pequeña."}

---

## 2. Engagement en GA4

*Fuente: Google Analytics 4 — últimos 30 días*

### Por dispositivo

| Dispositivo | Sesiones | Bounce rate | Duración prom. | Páginas/sesión |
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

| Canal | Sesiones | Bounce rate | Calidad |
|---|---|---|---|
| {canal} | {n} | {%} | {emoji} |
| {canal} | {n} | {%} | {emoji} |

> [!note] Interpretación de engagement
> {hallazgo clave — ej: "El tráfico orgánico tiene bounce del 25%, mientras el tráfico directo alcanza el 70%, lo que sugiere que los usuarios que llegan por búsqueda tienen una intención más clara que los que navegan directamente."}

---

## 3. Performance (Core Web Vitals)

*Fuente: PageSpeed Insights*

| Métrica | Mobile | Desktop | Umbral óptimo |
|---|---|---|---|
| LCP | {valor} | {valor} | ≤2.5s |
| CLS | {valor} | {valor} | ≤0.1 |
| INP | {valor} | {valor} | ≤200ms |
| FCP | {valor} | {valor} | ≤1.8s |
| TTFB | {valor} | {valor} | ≤800ms |

**Score PageSpeed**: Mobile {score}/100 · Desktop {score}/100

{Si hay top opportunity:}
> [!danger] Oportunidad principal de performance
> {descripción de la optimización con mayor impacto estimado}

---

## 4. Comparativa mobile vs desktop

*Fuente: GA4 + PageSpeed Insights*

| Dimensión | Mobile | Desktop | Diferencia | Estado |
|---|---|---|---|---|
| Bounce rate | {%} | {%} | {+/- X pts} | {emoji} |
| Duración promedio | {mm:ss} | {mm:ss} | {+/- X%} | {emoji} |
| LCP | {valor} | {valor} | {diferencia} | {emoji} |
| CLS | {valor} | {valor} | {diferencia} | {emoji} |

> [!{tip|warning|danger}] Diagnóstico mobile
> {hallazgo — ej: "La página presenta degradación significativa en mobile: bounce 35 puntos mayor que desktop y LCP 3x más lento. Prioridad: revisar imágenes sin optimización y layout de columnas en pantallas pequeñas."}

---

## 5. Hallazgos y recomendaciones

### Contenido

- **{hallazgo}** — {evidencia: ej "scroll depth 30% sugiere que los usuarios no llegan al cuerpo del artículo"}
  → Recomendación: {acción concreta}

### Interacción

- **{hallazgo}** — {evidencia: ej "rage clicks en zona del formulario"}
  → Recomendación: {acción concreta}

### Layout y diseño visual

- **{hallazgo}** — {evidencia}
  → Recomendación: {acción concreta}

### Performance

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

- **GA4 property**: {property_id} ({nombre de la propiedad})
- **Clarity project**: {nombre del MCP utilizado}
- **Período**: {fecha inicio} — {fecha fin}
- **MCPs no disponibles**: {listar si aplica, o "Todos los MCPs respondieron correctamente"}
