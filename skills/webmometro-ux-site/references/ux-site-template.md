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

> [!abstract] UX Health Score: {score}/100 — {estado}
> {1-2 líneas con el hallazgo más importante del sitio en términos de UX}

| Categoría | Puntuación | Estado |
|---|---|---|
| Frustración (rage/dead clicks, quick backs) | {pts}/100 | {emoji} |
| Engagement (scroll depth, duración, bounce) | {pts}/100 | {emoji} |
| Performance CWV | {pts}/100 | {emoji} |
| Paridad mobile/desktop | {pts}/100 | {emoji} |
| Errores JavaScript | {pts}/100 | {emoji} |
| **TOTAL** | **{score}/100** | **{emoji} {estado}** |

Rangos: 🟢 Excelente 85-100 / 🟡 Bueno 70-84 / 🟠 Necesita mejoras 50-69 / 🔴 Crítico 0-49

---

## 1. Audiencia y dispositivos

*Fuente: Google Analytics 4 — últimos 30 días*

### Por dispositivo

| Dispositivo | Sesiones | % del total | Bounce rate | Duración prom. |
|---|---|---|---|---|
| Mobile | {n} | {%} | {%} | {mm:ss} |
| Desktop | {n} | {%} | {%} | {mm:ss} |
| Tablet | {n} | {%} | {%} | {mm:ss} |

### Nuevos vs recurrentes

| Tipo de usuario | Sesiones | Bounce rate | Duración prom. |
|---|---|---|---|
| Nuevos | {n} | {%} | {mm:ss} |
| Recurrentes | {n} | {%} | {mm:ss} |

> [!note] Interpretación
> {hallazgo clave sobre dispositivos y tipo de usuario — ej: "El mobile representa el X% del tráfico pero tiene un bounce X% mayor que desktop, señal de problemas de experiencia en pantallas pequeñas."}

---

## 2. Páginas con mayor frustración

*Fuente: Microsoft Clarity — últimos 30 días*

> [!warning] Páginas con señales de frustración activa
> Ordenadas de mayor a menor nivel de frustración combinado.

| Página | Quick backs | Rage clicks | Dead clicks | Nivel |
|---|---|---|---|---|
| {url} | {%} | {%} | {%} | 🔴 Alto |
| {url} | {%} | {%} | {%} | 🟠 Medio |
| {url} | {%} | {%} | {%} | 🟡 Bajo |

**Umbrales**: Quick backs >40% 🔴 / Rage clicks >5% 🔴 / Dead clicks >10% 🟠

---

## 3. Engagement por página

*Fuente: GA4 + Microsoft Clarity — últimos 30 días*

### Páginas estrella (alto engagement)

| Página | Sesiones | Bounce rate | Duración prom. | Scroll depth |
|---|---|---|---|---|
| {url} | {n} | {%} | {mm:ss} | {%} |

### Páginas problema (bajo engagement)

| Página | Sesiones | Bounce rate | Duración prom. | Scroll depth |
|---|---|---|---|---|
| {url} | {n} | {%} | {mm:ss} | {%} |

### Páginas con potencial (tráfico alto, engagement medio)

| Página | Sesiones | Bounce rate | Oportunidad |
|---|---|---|---|
| {url} | {n} | {%} | {descripción breve} |

---

## 4. Flujos de navegación y puntos de salida

*Fuente: Google Analytics 4 — últimos 30 días*

### Calidad por canal de entrada

| Canal | Sesiones | Bounce rate | Duración prom. | Calidad |
|---|---|---|---|---|
| {canal} | {n} | {%} | {mm:ss} | {emoji} |

### Top páginas de salida

| Página | Salidas | % salidas | Acción sugerida |
|---|---|---|---|
| {url} | {n} | {%} | {acción} |

> [!tip] Hallazgo de navegación
> {insight sobre dónde se pierden los usuarios y por qué}

---

## 5. Performance técnica (CWV)

*Fuente: PageSpeed Insights — homepage*

| Métrica | Mobile | Desktop | Umbral |
|---|---|---|---|
| LCP | {valor} | {valor} | ≤2.5s ✅ |
| CLS | {valor} | {valor} | ≤0.1 ✅ |
| INP | {valor} | {valor} | ≤200ms ✅ |
| FCP | {valor} | {valor} | ≤1.8s ✅ |
| TTFB | {valor} | {valor} | ≤800ms ✅ |

**Score PageSpeed**: Mobile {score}/100 · Desktop {score}/100

> [!danger] Oportunidad principal de performance
> {top opportunity detectado por PageSpeed, si existe}

---

## 6. Errores JavaScript

*Fuente: Microsoft Clarity — últimos 30 días*

| Error | Frecuencia | Páginas afectadas |
|---|---|---|
| {descripción del error} | {n} veces | {páginas} |

{Si no hay errores: "> ✅ No se detectaron errores JavaScript en el período analizado."}

---

## 7. Plan de acción

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

- **GA4 property**: {property_id} ({nombre de la propiedad})
- **Clarity project**: {nombre del MCP utilizado}
- **Período**: {fecha inicio} — {fecha fin}
- **MCPs no disponibles**: {listar si aplica, o "Todos los MCPs respondieron correctamente"}
