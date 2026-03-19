---
name: webmometro-seo-site-profile
description: |
  Genera el perfil SEO completo de un dominio: métricas de autoridad, tecnologías,
  categorías de industria, historial WHOIS y posicionamiento general.
  Triggers: "perfil del sitio", "site profile", "métricas seo dominio", "información del dominio"
argument-hint: "[dominio]"
allowed-tools: Read, Write, Glob
---

# webmometro-seo-site-profile — Perfil del Sitio

Genera un perfil SEO completo del dominio con todas sus métricas clave.

## Invocación

```
/webmometro-seo site-profile [dominio]
```

## Flujo de ejecución

1. `mcp__dataforseo__labs_google_domain_rank_overview` → métricas de ranking orgánico
2. `mcp__dataforseo__backlinks_summary` → autoridad: DA, CF, TF, referring domains
3. `mcp__dataforseo__domain_analytics_technologies_domain_technologies` → stack tecnológico
4. `mcp__dataforseo__labs_google_categories_for_domain` → categorías de industria
5. `mcp__dataforseo__domain_analytics_whois_overview` → información WHOIS y antigüedad del dominio
6. `mcp__gsc__search_analytics` → métricas reales de búsqueda (si el dominio está en GSC)
7. `mcp__pagespeed__analyze_pagespeed` → Core Web Vitals de la homepage
8. Guarda en `reports/site-profiles/{dominio}-{fecha}.md`

## Template de reporte

```markdown
# Perfil del Sitio: {dominio}
**Fecha**: {date}

## Métricas de autoridad
| Métrica | Valor |
|---|---|
| Domain Authority | |
| Citation Flow | |
| Trust Flow | |
| Referring Domains | |
| Antigüedad del dominio | |

## Rendimiento orgánico
| Métrica | Valor |
|---|---|
| Keywords rankeando | |
| Tráfico orgánico est. | |
| Posición promedio (GSC) | |

## Tecnologías detectadas
| Categoría | Tecnología |
|---|---|
| CMS | |
| Analytics | |
| CDN | |
| Framework | |

## Core Web Vitals (homepage)
| Métrica | Mobile | Desktop |
|---|---|---|
| LCP | | |
| CLS | | |
| INP | | |

## Industria y categorías
{categorías identificadas por DataForSEO}
```
