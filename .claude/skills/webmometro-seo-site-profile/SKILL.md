---
name: webmometro-seo-site-profile
description: |
  Genera y actualiza el perfil de contexto del negocio para un dominio.
  Analiza el sitio con MCPs para inferir qué hace el negocio, a quién le vende,
  sus competidores y estrategia de contenido. Genera un borrador que el usuario valida.
  Todos los demás skills webmometro-seo leen este contexto automáticamente.
  Usar siempre que el usuario mencione: "context", "perfil del negocio", "contexto del sitio",
  "definir negocio", "configurar dominio", "analiza este sitio", "¿qué hace este negocio?",
  "prepara el contexto", "antes de auditar", "configura el dominio", "setup del sitio",
  "antes de hacer la auditoría", "set up the site", "business context", "site context",
  "quiero auditar", "vamos a trabajar con", "empecemos con el dominio".
metadata:
  argument-hint: "[dominio]"
---

# webmometro-seo-site-profile — Site Profile

Genera el perfil del negocio para un dominio. Todos los skills webmometro-seo lo leen automáticamente antes de cada análisis, permitiéndoles hacer recomendaciones contextualizadas al negocio en lugar de análisis genéricos.

## Invocación

```
/webmometro-seo context [dominio]
```

## Configuración de ruta de reportes

Al iniciar, resolver la ruta base de reportes:

- Si `$SEO_REPORTS_PATH` está definida → usar ese valor como `REPORTS_DIR`
- Si no está definida → usar `{cwd}/reports` como `REPORTS_DIR` y advertir al usuario:
  > "No encontré `SEO_REPORTS_PATH`. Guardando reportes en `{cwd}/reports`. Para usar otra ubicación, define `SEO_REPORTS_PATH` en `.claude/settings.json`."

Si `REPORTS_DIR` no existe, crearlo con `mkdir -p` antes de continuar.

Todas las referencias a `$SEO_REPORTS_PATH` en este skill se resuelven como `REPORTS_DIR`.

---

## Manejo de contexto existente

Antes de iniciar, verificar si ya existe `$SEO_REPORTS_PATH/{dominio}/site-profile.md`:

- **Si no existe**: ejecutar el flujo completo sin preguntar nada.

- **Si existe**: leer la fecha de "Última actualización" del archivo y calcular cuántos días han pasado desde hoy.

  - **Si han pasado más de 15 días**: informar brevemente la fecha y preguntar si actualiza todo o solo secciones (ver lista abajo).

  - **Si han pasado 15 días o menos**: el contexto es reciente — presumir que la mayoría de la información sigue vigente. Mostrar el mensaje siguiente y pedir al usuario que indique qué secciones actualizar anotando los números. Si responde "todo" o "A", ejecutar el flujo completo. Si no responde nada o dice que está bien, detener.

  > "El site profile de `{dominio}` fue actualizado hace {N} días ({fecha}). La información es reciente — probablemente no necesita regenerarse por completo.
  >
  > Si quieres actualizar alguna sección específica, indica los números (ej: 3, 7). Puedes indicar varias. Para regenerar todo escribe **A**. Para cancelar escribe **C**.
  >
  > **Secciones disponibles:**
  > 1. El negocio (descripción, objetivo, industria)
  > 2. Audiencias y viabilidad de demanda
  > 3. Propuesta de valor
  > 4. Competidores SERP
  > 5. Peers organizacionales
  > 6. Pilares de contenido
  > 7. Tono y voz de marca
  > 8. Keywords prioritarias GSC (top 20)
  > 9. Páginas con mayor potencial de crecimiento
  > 10. Páginas en caída recuperable
  > 11. Notas técnicas (OnPage score, issues)
  > 12. Notas estratégicas"

  Al recibir los números, ejecutar **solo los pasos necesarios** para regenerar esas secciones, evitando llamadas a MCPs de pago para las secciones que no se actualizan. Mapeo orientativo de secciones a pasos:
  - Secciones 1, 3, 7: se pueden actualizar con OnPage (Paso 1.1) o revisión del sitio.
  - Secciones 2 (audiencias + viabilidad): requiere Pasos 2 y 2b (keywords Google Ads API).
  - Secciones 4, 5: requiere Paso 1.3 (competidores DataForSEO) y Paso 1.5 (SERPs).
  - Secciones 6: requiere keywords disponibles (GSC o DataForSEO).
  - Secciones 8, 9, 10: requieren GSC (Paso 1.2, dimensiones query y page) — sin costo adicional.
  - Sección 11: requiere OnPage (Paso 1.1).
  - Sección 12: se puede derivar de los datos ya disponibles en el archivo, sin llamadas externas.

## Flujo de ejecución

### Paso 1 — Análisis automático

Usa los MCPs en paralelo para inferir el contexto sin preguntar nada al usuario:

1. **OnPage** — `mcp__dataforseo__onpage_task_post` en la homepage. Este MCP es **asíncrono**: después de crear la tarea, pollear con `mcp__dataforseo__onpage_tasks_ready` hasta que el estado sea `ready`, luego obtener resultados con `mcp__dataforseo__onpage_pages`. Extraer: title, meta, H1-H2, body text, onpage_score, issues detectados (sin H1, título largo, sin alt text, CMS detectado, etc.).
   - Reintentar hasta 3 veces con ~5s entre intentos.
   - Si después de 3 intentos no está lista: **continuar con los pasos 2-5**, guardar el `task_id` en una variable temporal, y añadir una nota interna "⏳ OnPage pendiente — retomar al final".
   - **Al finalizar el Paso 5**, si OnPage quedó pendiente: hacer un último intento de polling. Si ahora está lista, incorporar los datos técnicos al borrador y al guardado. Si sigue sin estar lista, guardar de todas formas y marcar en `## Notas técnicas`: "OnPage no disponible al momento de la generación — ejecutar `onpage_task_get` manualmente con task_id: {id}".

2. **Keywords GSC** — Hacer dos llamadas en paralelo:
   - `mcp__gsc__search_analytics` con dimensión `query` → top 20 keywords por clicks (últimos 90 días). Fuente para keywords prioritarias.
   - `mcp__gsc__search_analytics` con dimensión `page` → top 50 páginas por impresiones (últimos 90 días). Fuente para las secciones de potencial de crecimiento y caída recuperable.

   Si GSC falla o retorna vacío, usar `mcp__dataforseo__labs_google_ranked_keywords` (target: dominio, location_code: 2152, language_code: es, limit: 20) como fuente alternativa para keywords. Notificar al usuario cuál fuente se usó. Si GSC no está disponible, omitir las secciones de potencial de crecimiento y caída recuperable, anotándolo en Notas estratégicas.
   - Si ambas retornan vacío: continuar con los datos disponibles, advertir al usuario: "No se encontraron keywords rankeadas. El análisis de pilares será parcial." y estimar viabilidad de demanda usando keywords inferidas por industria/audiencia (ver Paso 2b).

3. **Competidores** — `mcp__dataforseo__labs_google_competitors_domain` (target: dominio, location_code: 2152, language_code: es, limit: 15) → dominios competidores según Google.

4. **Industria** — `mcp__dataforseo__labs_google_categories_for_domain` (target: dominio — solo este parámetro) → categoría de industria. Si falla, omitir sin interrumpir el flujo.

5. **SERPs** — Con las top 3 keywords por clicks (o las disponibles si hay menos), llamar a `mcp__dataforseo__serp_google_organic_live` × N (location_code: 2152, language_code: es, depth: 10) → dominios orgánicos reales en SERPs relevantes. **Importante**: los resultados de SERP pueden ser archivos grandes — extraer solo el campo `domain` de cada item orgánico. No asumir competidores que no aparezcan en los datos.

6. **Peers organizacionales** — Antes de buscar, inferir tres dimensiones del dueño del sitio a partir de los datos ya recopilados (OnPage, keywords, industria):
   - **Tipo de organización**: ONG, empresa privada, institución pública, asociación gremial, etc.
   - **Nicho específico**: qué hace realmente (ej: investigación oncológica + políticas públicas, no "atención al paciente")
   - **Alcance geográfico real**: inferir a partir del dominio TLD, el idioma del sitio, las keywords y el body text. Criterio por defecto: **el alcance es el país del TLD** (ej: `.cl` → Chile, `.mx` → México). Solo ampliar a regional o global si hay evidencia explícita: múltiples países mencionados, versiones en varios idiomas, o keywords con modificadores de otros países. **No asumir alcance regional o global por el tema del negocio** — una fundación de cáncer chilena tiene alcance nacional a menos que los datos digan lo contrario.

   Con estas tres dimensiones, construir 2-3 queries que busquen organizaciones del **mismo país** (o alcance inferido), mismo tipo y mismo nicho. Ejemplo para una fundación oncológica chilena de investigación y políticas: "fundacion cancer investigacion chile", "observatorio salud publica chile", "think tank politicas salud chile". Llamar a `mcp__dataforseo__serp_google_organic_live` con `location_code` del país correspondiente. Extraer solo dominios.

   Al filtrar resultados: **conservar solo organizaciones del mismo país/alcance y cuyo nicho principal coincida con el del dueño del sitio**. Descartar organizaciones de otros países aunque sean del mismo sector, y descartar organizaciones de nicho diferente aunque sean del mismo país (ej: si el dueño se enfoca en investigación y políticas, descartar clínicas y hospitales de atención).

### Paso 2 — Inferencia de audiencias

Antes de clasificar competidores o analizar viabilidad, inferir las audiencias del negocio. Usar como fuentes:
- **Body text y H1-H2** del OnPage (si disponible): lenguaje dirigido al visitante, verbos en imperativo, menciones de "tú/usted/ustedes".
- **Keywords GSC o DataForSEO**: agrupar por intención — informacional, transaccional, navegacional. Las keywords transaccionales revelan quién compra.
- **Meta description y title**: a quién se presenta el negocio.
- **Industria inferida**: usar conocimiento del dominio para listar audiencias típicas.

Definir entre 1 y 4 audiencias. Cada audiencia debe tener:
- **Nombre**: etiqueta corta (ej: "Pacientes con cáncer", "Empresas B2B tecnológicas")
- **Descripción**: su problema principal y quién es
- **Tipo**: B2C / B2B / mixto
- **Rol para la organización**: Principal / Secundario / Periférico — según su importancia para la misión y sostenibilidad del negocio
- **Cómo se logra que llegue**: canal o estrategia resumida en pocas palabras (ej: "SEO informacional", "LinkedIn + eventos", "PR digital")

Si no hay suficientes datos para inferir audiencias, asumir una audiencia genérica basada en la industria y marcarla como "inferida sin datos suficientes".

La **audiencia objetivo SEO** es la que tiene veredicto ✅ VIABLE en el Paso 2b y mayor probabilidad de cumplir el objetivo del sitio. Se menciona como una línea al final de la sección de audiencias.

### Paso 2a — Clasificación de competidores

Con los dominios recopilados, clasificar en dos listas distintas:

**Competidores SERP** — dominios que aparecen en las SERPs de las keywords del negocio. Separar en:
- *Nacionales*: dominios del mismo país
- *Internacionales*: dominios de otros países

Para cada competidor, inferir brevemente "por qué compite" (overlap de keywords, mismo tipo de producto, etc.).

Filtrar dominios no relevantes: redes sociales (instagram.com, facebook.com, youtube.com, tiktok.com), Wikipedia, agregadores genéricos.

**Peers organizacionales** — organizaciones cuyo **nicho específico y alcance geográfico** son afines al dueño del sitio (no basta el sector amplio). Mínimo 8, idealmente 10+. Para cada peer incluir:
- **Tipo**: tipo de organización (ONG, empresa, institución pública, etc.)
- **Nicho**: qué hace concretamente (no el sector, sino la actividad principal)
- **Alcance**: local / nacional / regional / global

Descartar peers cuyo nicho no coincida aunque pertenezcan al mismo sector. Ejemplo: si el dueño hace investigación y políticas públicas sobre cáncer, excluir hospitales y clínicas aunque sean "organizaciones de cáncer". Útiles para análisis de gaps de contenido y benchmarks de estrategia.

### Paso 2b — Viabilidad de demanda por audiencia

Ejecutar este paso **siempre**, independientemente de si el negocio tiene una o varias audiencias.

El veredicto debe ser verificable: el usuario necesita ver exactamente qué keywords se consultaron y cuánto volumen tiene cada una para confiar en la clasificación. No basta reportar el total — hay que mostrar el desglose.

Para cada audiencia definida en el Paso 2:
1. Razonar cómo esa audiencia buscaría en Google — pensar en sus palabras reales, no en términos técnicos del negocio. Documentar este razonamiento brevemente al presentar los resultados.
2. Generar 6-8 keywords representativas: términos amplios + long tail + variantes sin modificador geográfico.
3. Llamar a `mcp__dataforseo__keywords_google_ads_search_volume` (location_code: 2152, language_code: es).
4. Para cada keyword retornada, registrar: keyword, volumen mensual (null si está bajo el umbral), y si fue inferida o proviene de GSC.
5. Calcular el volumen total del clúster (sumando solo las keywords con volumen > 0) y clasificar:
   - ✅ VIABLE: >500 búsquedas/mes — SEO justificado
   - ⚠️ BAJA: 50-500 búsquedas/mes — SEO posible pero con expectativas bajas
   - ❌ NULA: <50 búsquedas/mes — SEO no es el canal
6. Para cada audiencia, redactar un **Ajuste estratégico** que responda: ¿dónde está la ventana real de oportunidad? ¿qué keywords atacar primero? ¿qué obstáculos o limitaciones hay? Este es el insight más accionable de la sección — debe ser concreto y basado en los datos, no genérico.
7. Para audiencias ⚠️ o ❌: recomendar canal alternativo (newsletter, PR digital, LinkedIn, eventos, etc.).

**Si no hay keywords disponibles** (dominio nuevo, sin GSC, sin autoridad): usar `mcp__dataforseo__keywords_google_ads_search_volume` directamente con keywords inferidas por industria/audiencia para estimar la demanda potencial antes de concluir que es ❌.

**Nota**: Keywords con modificadores locales específicos ("chile", "minsal", etc.) tienden a retornar null porque el volumen está bajo el umbral mínimo (~10/mes). Usar primero términos amplios y agregar variantes locales solo si el término base tiene volumen.

### Paso 2c — Páginas con potencial de crecimiento y páginas en caída

Usando los datos de páginas por impresiones (dimensión `page`) obtenidos en el Paso 1:

**Potencial de crecimiento** — páginas en posición 4-20 con impresiones altas y CTR bajo. El razonamiento: una página en posición 7 con 5,000 impresiones captura ~2-3% de clicks; en posición 3 capturaría ~10-15%. El salto es multiplicador, no incremental.
- Seleccionar 5-8 páginas que cumplan: posición entre 4 y 20, impresiones > 200 en 90 días, CTR < 10%.
- Para cada página, inferir la keyword principal (la que aporta más impresiones a esa URL, cruzando con los datos de `query`).
- Estimar el CTR potencial en top 3 usando referencias estándar: pos 1 → ~28%, pos 2 → ~15%, pos 3 → ~10%.
- Redactar una recomendación concreta: no "mejorar el contenido" sino algo específico como "añadir tabla de precios", "reforzar el H1 con la keyword exacta", "agregar datos actualizados 2025", "consolidar con la página /similar-url que canibaliza".

**Páginas en caída recuperable** — páginas que perdieron posición pero tienen señales de que pueden remontar. Sin acceso a datos históricos comparativos en GSC directamente, identificar indirectamente: páginas con impresiones sostenidas (> 500/90d) pero CTR muy bajo (< 2%) y posición > 10. Esto indica que Google las indexa pero ya no las prefiere — el contenido probablemente está desactualizado o fue superado por competidores.
- Seleccionar 3-6 páginas con estas características.
- Inferir la causa probable de la caída: contenido desactualizado (sin fechas recientes), competidor nuevo bien posicionado, cambio de intención de búsqueda, fragmentación con otra URL del mismo sitio.
- Redactar la acción prioritaria de recuperación: "actualizar estadísticas", "agregar sección de preguntas frecuentes", "consolidar con /otra-url", "reescribir el intro con respuesta directa a la query".

Si GSC no está disponible, omitir ambas secciones y anotarlo en Notas estratégicas.

### Paso 3 — Pilares de contenido

Con las keywords disponibles (GSC o DataForSEO), agrupar semánticamente en pilares de contenido:
- Generar entre **4 y 8 pilares** (ni más, ni menos).
- Cada pilar debe tener un **nombre temático claro** (no una keyword literal), ej: "Diagnóstico y tratamiento", "Precios y costos", "Cómo funciona el servicio".
- Asignar prioridad según: volumen de búsquedas + clicks actuales + relevancia para el objetivo del negocio.
- Cada pilar debe tener al menos 2 keywords asociadas.
- Para cada keyword, inferir la **intención de búsqueda**: Informacional / Transaccional / Navegacional / Comparativa.

Si no hay keywords disponibles, construir los pilares basándose en la industria y audiencias inferidas, y marcarlos como "estimados sin datos de keywords".

### Paso 4 — Borrador y validación

Presenta el borrador al usuario. Incluir TODAS las secciones para que el usuario pueda validar y corregir:

```
He analizado [dominio] y esto es lo que inferí. Corrígeme en lo que esté mal:

**Negocio**: [descripción en 1-2 líneas]
**Objetivo principal**: [leads / ventas / tráfico informacional / marca]
**Industria**: [categoría inferida]
**Propuesta de valor**: [diferenciador]

**Audiencias**
| Nombre | Tipo | Descripción | Rol para la organización | Cómo se logra que llegue |
|---|---|---|---|---|
| [audiencia] | B2C/B2B/mixto | [descripción breve] | Principal/Secundario/Periférico | [canal resumido] |

**Audiencia objetivo SEO**: [quién llega por Google y tiene mayor probabilidad de cumplir el objetivo del sitio]

**Viabilidad de demanda**
| Audiencia | Volumen total clúster | Veredicto | Canal recomendado |
|---|---|---|---|
| [audiencia] | [vol. total]/mes | ✅ / ⚠️ / ❌ | [canal] |

*Por audiencia — detalle:*
**[Audiencia]** — cómo busca: [razonamiento]
[Por qué importa que llegue: valor para la organización — sin título, texto corrido]
| Keyword | Volumen/mes | Fuente |
|---|---|---|
| [keyword] | [vol] | inferida / GSC |
| [keyword] | null | inferida |
Volumen total: [X]/mes → [veredicto]
#### Ajuste estratégico
[oportunidad concreta, keywords a atacar primero, obstáculos]

**Competidores SERP**
- Nacionales: [dominio — por qué compite]
- Internacionales: [dominio — por qué compite]

**Peers organizacionales**
| Dominio | Tipo | Nicho específico | Alcance |
|---|---|---|---|
| [dominio] | [ONG / empresa / institución pública / etc.] | [qué hace concretamente] | [local / nacional / regional / global] |

**Keywords prioritarias GSC — últimos 90 días**
| Keyword | Clicks | Impresiones | CTR | Posición | Intención |
|---|---|---|---|---|---|
| [keyword] | [clicks] | [impresiones] | [ctr]% | [posición] | [Info/Trans/Nav/Comp] |
... (top 20 por clicks)

**Páginas con mayor potencial de crecimiento**
| Página · *keyword* | Métricas | Recomendación |
|---|---|---|
| [url]<br>*[keyword]* | pos [pos] · [imp] imp · CTR [ctr]% → ~[ctr_est]% top 3 | [acción concreta] |

**Páginas en caída recuperable**
| Página · *keyword* | Métricas | Diagnóstico y acción |
|---|---|---|
| [url]<br>*[keyword]* | pos [pos] · [imp] imp · CTR [ctr]% | [por qué puede recuperarse] → [acción concreta] |

**Pilares de contenido**
| Tema | Keywords relacionadas | Intención predominante | Prioridad |
|---|---|---|---|
| [nombre temático] | [keywords] | [Info/Trans/Nav] | Alta / Media / Baja |
... (4-8 pilares)

**Tono y voz de marca**
- Tono: [formal / conversacional / técnico / inspiracional]
- Características: [rasgos observados en el copy del sitio]
- Evitar: [qué parece no ir con la marca]

¿Qué ajustarías?
```

### Paso 5 — Guardado

Incorpora correcciones y guarda en `$SEO_REPORTS_PATH/{dominio}/site-profile.md` usando el template en `references/context-template.md`.

**Campos obligatorios a completar al guardar:**
- `{date}` en "Generado" y "Última actualización" → usar la fecha actual (formato: YYYY-MM-DD)
- Audiencias → tabla con columnas Nombre / Tipo / Rol para la organización / Descripción y cómo buscan; seguida de una línea de **Audiencia objetivo SEO**
- Viabilidad de demanda → inmediatamente después de Audiencias; incluir tabla resumen + bloque por audiencia con: razonamiento de búsqueda, por qué importa que llegue (texto corrido sin título), tabla de keywords, volumen total, y sección "#### Ajuste estratégico" destacada
- Competidores SERP → tabla con columna "Por qué compite" + sección separada de Peers con columna "Tipo de organización"
- Todos los pilares validados con columna "Intención predominante"
- Keywords prioritarias: guardar el **top 20** con columnas "CTR" e "Intención"
- **Páginas con mayor potencial de crecimiento**: guardar la tabla con 5-8 páginas, posición 4-20, incluyendo CTR estimado top 3 y recomendación concreta. Omitir sección si GSC no estuvo disponible.
- **Páginas en caída recuperable**: guardar la tabla con 3-6 páginas, incluyendo causa probable y acción prioritaria. Omitir sección si GSC no estuvo disponible.
- Tono y voz de marca: guardar los tres campos (Tono, Características, Evitar)
- **Notas estratégicas**: redactar 2-4 observaciones sobre la estrategia SEO actual basadas en el análisis (ej: "El sitio tiene tráfico de marca pero escaso contenido informacional", "Hay competidores internacionales bien posicionados en keywords transaccionales clave").
- **Notas técnicas**: onpage_score, issues detectados, CMS detectado. Si OnPage no estuvo disponible, registrar: "OnPage no disponible al momento de la generación — ejecutar `onpage_task_get` manualmente con task_id: {id}".

Al finalizar informar:
> "Site profile guardado en `$SEO_REPORTS_PATH/{dominio}/site-profile.md`. Si tienes pautas internas, marcos SEO o guías de marca, agrégalos como archivos `.md` en `$SEO_REPORTS_PATH/{dominio}/user-context/` — los skills los leerán automáticamente con prioridad sobre este archivo."

## Estructura de archivos

```
$SEO_REPORTS_PATH/{dominio}/
├── site-profile.md         ← generado por este skill
└── user-context/           ← archivos propios del usuario (prioridad)
    ├── marco-seo.md
    ├── brand-guidelines.md
    └── [cualquier .md]
```

## Cómo leen el contexto los demás skills

```
1. Verificar si existe $SEO_REPORTS_PATH/{dominio}/user-context/*.md → leerlos (prioridad)
2. Verificar si existe $SEO_REPORTS_PATH/{dominio}/site-profile.md → leerlo
3. Si no existe → sugerir: "/webmometro-seo-site-profile {dominio}"
```

## Política de errores de MCP

Si un MCP falla, no está disponible, o no retorna datos, **nunca omitir silenciosamente**. En todos los casos:

1. Continuar con los demás pasos sin interrumpir el flujo
2. En la sección correspondiente del contexto generado, registrar:

```
> ⚠️ **Datos no disponibles** — {nombre del MCP} no respondió o no está instalado.
> Sin estos datos, {descripción del valor que aportaría}.
> Para obtener esta información, instala o verifica la configuración de `{nombre-mcp}`.
```

Referencia por MCP y sección afectada:

| MCP | Sección afectada | Valor que aportaría si estuviera activo |
|---|---|---|
| `dataforseo` (OnPage) | Notas técnicas | OnPage score, issues, CMS detectado, title/meta/H1 reales |
| `dataforseo` (competitors) | Competidores SERP | Dominios que compiten orgánicamente según Google |
| `dataforseo` (categories) | El negocio | Categoría de industria inferida por Google |
| `dataforseo` (SERP) | Competidores SERP, Peers | Dominios orgánicos reales en SERPs relevantes |
| `dataforseo` (search volume) | Viabilidad de demanda | Volumen mensual de búsqueda de keywords objetivo |
| `gsc` | Keywords prioritarias, Páginas con potencial, Páginas en caída | Clicks, impresiones, CTR, posición real de keywords y páginas |

---

## Template de reporte

Ver [references/context-template.md](references/context-template.md)