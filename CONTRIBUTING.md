# Ciclo de Mejora de Skills — Webmometro SEO

Los skills no se mejoran manualmente ni al azar. Existe un ciclo estructurado con tres momentos distintos, cada uno con un propósito diferente.

---

## Los tres momentos del ciclo

### Momento 1 — Al crear un skill nuevo

Antes de publicar un skill nuevo, validar:

- El frontmatter es correcto (name, description, triggers en español e inglés)
- Los triggers disparan en los casos esperados y no disparan en falsos positivos
- El output tiene estructura consistente (secciones definidas, formato Markdown)
- Las referencias a otros skills (`webmometro-seo-serp`, `webmometro-seo-benchmarks`, etc.) son correctas
- Existe al menos un caso de prueba documentado en `skills/{nombre}/tests/`

### Momento 2 — Después de uso en producción

Este es el momento más valioso. Después de usar un skill con un dominio real:

1. **Reportar** qué salió mal o qué faltó — en el issue del repositorio o directamente al ejecutar `/webmometro-seo improve`
2. **El Skill Creator analiza**:
   - ¿El trigger disparó correctamente?
   - ¿El output fue accionable o genérico?
   - ¿Faltaron datos que los MCPs disponibles podían proveer?
   - ¿El skill llamó a otros skills correctamente (auto-calls)?
3. **Propuesta de mejora** — el Skill Creator genera un diff del SKILL.md con los cambios sugeridos
4. **Validación** — el usuario revisa y aprueba antes de aplicar
5. **Actualizar el repositorio** — commit al repo `webmometro-seo-skills` y reinstalar con `npx skills add marcelocampana/webmometro-seo-skills --yes`

### Momento 3 — Con nuevas versiones del modelo

Cuando sale un modelo nuevo (ej. Claude Opus 5, Sonnet 5), algunos skills pueden mejorar sin cambiar el SKILL.md porque el modelo es más capaz. Pero otros necesitan ajustes para aprovechar nuevas capacidades:

- Razonamiento multi-paso más largo → simplificar instrucciones redundantes
- Mejor uso de herramientas → reducir pasos manuales que antes requerían guía explícita
- Mayor ventana de contexto → consolidar skills que antes debían dividirse

**Señal de que un skill necesita actualización por modelo nuevo**: el output es notablemente mejor en algunas secciones pero inconsistente en otras — indica que el skill tiene instrucciones que compensaban limitaciones del modelo anterior.

---

## Comando `/webmometro-seo improve`

Ejecutar este comando activa el flujo de mejora integrado:

```
/webmometro-seo improve [nombre-del-skill]
```

El orquestador:
1. Lee el SKILL.md actual del skill indicado
2. Solicita al usuario que describa el problema observado (o lo infiere del contexto de la sesión)
3. Analiza si el problema es de trigger, output, integración con otros skills o cobertura de MCPs
4. Genera una propuesta de mejora en formato diff
5. Pide confirmación antes de aplicar cualquier cambio

Sin argumento (`/webmometro-seo improve`), analiza todos los skills usados en la sesión actual.

---

## Qué NO es una mejora válida

- Agregar más texto al output sin que resuelva un problema real
- Cambiar el formato sin evidencia de que el actual causa confusión
- Agregar dependencias a más MCPs sin necesidad demostrada
- "Mejorar" un skill que funcionó correctamente — si el output fue accionable, no tocar

---

## Estructura de un caso de prueba

```
skills/{nombre}/tests/
  caso-01.md     # Input: keyword/dominio + contexto
  caso-01-expected.md  # Output esperado (secciones mínimas requeridas)
```

Los casos de prueba son la base para las evals A/B: comparar el output actual vs el output después de un cambio propuesto.

---

## Fuente de verdad

El repositorio `marcelocampana/webmometro-seo-skills` es la fuente de verdad.

Los skills en `.agents/skills/` son symlinks — no editar ahí directamente.

Para aplicar mejoras:
```bash
# 1. Editar en el repositorio fuente
cd ~/Projects/webmometro-seo-skills
# ... hacer cambios ...
git add skills/{nombre}/SKILL.md
git commit -m "improve: {nombre} — {descripción del cambio}"
git push

# 2. Reinstalar en el proyecto
cd ~/Projects/dashboard-webmometro-seo
npx skills add marcelocampana/webmometro-seo-skills --yes
```
