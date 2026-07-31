---
name: skill-portfolio-management
description: Metodología para revisar, analizar y consolidar el portafolio de skills de Hermes Agent para eliminar redundancias y mejorar la organización. Incluye técnicas para identificar solapamientos, agrupar skills relacionados y crear habilidades de nivel de clase.
version: 1.0.0
author: Ariana (Hermes Agent)
license: MIT
platforms: [linux]
metadata:
  hermes:
    tags: [skill-management, consolidation, methodology, portfolio-analysis]
    related_skills: [hermes-agent-skill-authoring, hermes-agent]
---

# Skill Portfolio Management — Hermes Agent

Metodología sistemática para revisar, analizar y consolidar el portafolio de skills de Hermes Agent, eliminando redundancias y organizando el conocimiento en habilidades de nivel de clase.

## Cuándo Usar Esta Skill

- Cuando el portafolio de skills crece y comienza a tener redundancias
- Antes de crear nuevos skills para verificar si ya existe cobertura
- Cuando se solicita específicamente revisar o consolidar skills
- Periódicamente como mantenimiento del sistema de conocimiento
- Después de completar varios proyectos similares que podrían generar skills especializados

## Metodología de Revisión y Consolidación

### Fase 1: Inventario y Categorización

1. **Obtener lista completa de skills**
   - Usar `skills_list()` para obtener todos los skills disponibles
   - Anotar nombre, descripción y categoría de cada skill

2. **Agrupación preliminar por dominio**
   - Agrupar skills por palabras clave en descripción y nombre
   - Identificar clusters obvios (ej: todos los skills con "pentest", "fortinet", "ciberseguridad", etc.)
   - Separar skills de infraestructura, metodología, herramientas específicas, etc.

3. **Análisis de descripción y tags**
   - Comparar descripciones para identificar solapamientos semánticos
   - Examinar tags para encontrar taxonomías comunes
   - Revisar related_skills para ver conexiones ya identificadas

### Fase 2: Análisis de Contenido Detallado

4. **Revisión de contenido de skills candidatos**
   - Para cada cluster identificado, usar `skill_view(name)` para obtener el contenido completo
   - Comparar secciones, procedimientos, herramientas cubiertas y metodologías
   - Identificar contenido único vs. duplicado

5. **Identificación de patrones de redundancia**
   - **Redundancia total**: skills que cubren exactamente el mismo terreno
   - **Redundancia parcial**: skills que comparten secciones sustanciales pero tienen focos diferentes
   - **Complementariedad**: skills que se complementan naturalmente (ej: instalación + uso)
   - **Jerarquía implícita**: skills que son subconjuntos de otros más generales

### Fase 3: Diseño de la Arquitectura Consolidada

6. **Diseño de skills de nivel de clase**
   - Definir el alcance amplio que cubra múltiples skills específicos
   - Estructurar con secciones claras que mapeen a los skills originales
   - Incluir un directorio `references/` para detalles específicos de sesión
   - Mantener la profundidad técnica mientras se elimina la redundancia

7. **Plan de migración**
   - Identificar qué contenido de cada skill original se mueve donde
   - Determinar qué contenido único debe preservarse
   - Planificar cómo referenciar el contenido específico en `references/`
   - Considerar dependencias y skills relacionados

### Fase 4: Implementación y Validación

8. **Creación del skill consolidado**
   - Usar `skill_manage(action='create')` con el nuevo SKILL.md completo
   - Añadir archivos de soporte en `references/`, `templates/`, `scripts/` según corresponda
   - Incluir punteros en SKILL.md a los archivos de soporte

9. **Validación de cobertura**
   - Verificar que todo el contenido útil de los skills originales esté preservado
   - Confirmar que se eliminó la redundancia significativa
   - Asegurar que el nuevo skill siga siendo usable y enfocado

10. **Actualización de referencias**
    - Documentar qué skills fueron consolidados y en qué nuevo skill
    - Actualizar documentación interna o notas según corresponda

## Técnicas de Identificación de Redundancia

### Análisis de Descripción

Buscar solapamiento en:
- Verbos de acción (configurar, instalar, usar, analizar, diseñar)
- Objetos de acción (firewall, herramientas, redes, aplicaciones)
- Contextos de uso (Linux, Windows, cloud, redes específicas)

### Análisis de Contenido

Comparar secciones típicas:
- **Metodología**: ¿Usan el mismo enfoque o framework?
- **Herramientas**: ¿Cubren las mismas herramientas o categorías de herramientas?
- **Procedimientos**: ¿Tienen pasos similares para tareas comunes?
- **Escenarios**: ¿Abordan los mismos casos de uso o situaciones?

### Análisis de Uso

Considerar:
- ¿En qué situaciones se activaría cada skill?
- ¿Hay escenarios donde se usarían ambos?
- ¿Uno es un subconjunto claro del otro?
- ¿Se complementan o se sustituyen?

## Directrices para Skills de Nivel de Clase

### Estructura Recomendada

```\n# Skill Name — BRIDA IT Services\n\n## Descripción General\n[Alcance amplio que cubra múltiples casos de uso específico]\n\n## Cuándo Usar Este Skill\n[Guía para determinar cuándo aplicar este skill consolidado]\n\n## Secciones Principales\n\n### Sección 1: [Tema Amplio 1]\n- Contenido que antes estaba en Skill A, Subtema X\n- Contenido que antes estaba en Skill B, Subtema Y\n- [etc.]\n\n### Sección 2: [Tema Amplio 2]\n- Contenido que antes estaba en Skill A, Subtema Z\n- Contenido que antes estaba en Skill C, Subtema W\n- [etc.]\n\n## Referencias y Soporte\n\n### Directorio `references/`\n- `references/tema-especifico-a.md`: Detalles que antes estaban en Skill A\n- `references/tema-especifico-b.md`: Detalles que antes estaban en Skill B\n- [etc.]\n\n### Directorio `templates/`\n- Plantillas reutilizables extraídas de los skills originales\n\n### Directorio `scripts/`\n- Scripts de verificación, configuración o automatización\n\n## Flujo de Trabajo Típico\n\n1. [Paso inicial común]\n2. [Ramificación basada en necesidad específica]\n3. [Procedimientos detallados en referencias si se necesita profundidad]\n4. [Conclusión y próximos pasos]\n\n## Beneficios de la Consolidación\n\n- **Reducción de redundancia**: Menos duplicación de contenido\n- **Mejor descubrimiento**: Más fácil encontrar la información relevante\n- **Mantenimiento simplificado**: Actualizaciones en un solo lugar\n- **Coherencia mejorada**: Enfoque y terminología consistentes\n- **Context preservation**: Detalles específicos aún disponibles en references/\n\n## Trampas Comunes a Evitar\n\n- **Sobre-generalización**: Hacer el skill demasiado amplio para ser útil\n- **Pérdida de especificidad**: Eliminar detalles críticos que eran importantes en contexts específicos\n- **Estructura confusa**: No organizar claramente el contenido para navegación fácil\n- **Referencias inadequadas**: No proporcionar suficiente detalle en el directorio de referencias\n\n## Manejo de Inconsistencias de Nomenclatura y Skills Sin Categorizar\n\nAl consolidar skills, prestar especial atención a:\n\n1. **Variaciones de prefijos/suffijos**:\n   - Skills con `brida-` prefix vs `-brida` suffix (ej: `brida-cybersecurity-consulting` vs `cybersecurity-brida`)\n   - Elegir una convención consistente (recomendado: `-brida` suffix para skills de BRIDA IT Services)\n   - Mantener el skill con mejor contenido y renombrar según la convención elegida\n\n2. **Skills en "Uncategorized"**:\n   - Revisar todos los skills sin categoría y asignarlos a categorías apropiadas\n   - Skills de seguridad típicamente pertenecen a categoría `cybersecurity`\n   - Skills de herramientas específicas pueden ir a categorías temáticas apropiadas\n   - Evitar dejar skills importantes sin categorizar\n\n3. **Skills Referenciados pero No Existentes**:\n   - Verificar que todos los skills en `related_skills` realmente existen como skills independientes\n   - Eliminar referencias a skills inexistentes para evitar confusiones\n   - Si un skill referenciado es valioso pero no existe como independiente, considerar crearlo o integrar su contenido\n\n4. **Duplicados por Diferencias Menores**:\n   - Skills que difieren solo en versión number en descripción o contenido mínimo\n   - Fusionar en un solo skill con la mejor versión de cada componente\n   - Mantener historial de versiones en el skill consolidado si es relevante\n\n## Flujo de Trabajo de Consolidación (Ejemplo)\n\n```bash\n# 1. Obtener lista de skills\nskills_list()\n\n# 2. Identificar candidatos para consolidación (ej: habilidades de pentesting)\n# 3. Ver contenido de cada skill\nskill_view(name='pentest-arsenal-brida')\nskill_view(name='pentest-tool-installation')\nskill_view(name='pentesting-arsenal')\n\n# 4. Analizar solapamientos y diferencias\n# 5. Diseñar estructura consolidada\n# 6. Crear nuevo skill\nskill_manage(action='create', name='pentesting-brida', content='[SKILL.md completo]')\n\n# 7. Añadir archivos de soporte\nskill_manage(action='write_file', name='pentesting-brida', file_path='references/coverage-analysis.md', content='[contenido]')\nskill_manage(action='write_file', name='pentesting-brida', file_path='templates/installation-pattern.md', content='[plantilla]')\n\n# 8. Validar y documentar\n# ...\n```\n\n## Métricas de Éxito\n\n- **Reducción de skills**: % de skills consolidados sin pérdida de funcionalidad\n- **Preservación de conocimiento**: % de contenido útil único mantenido\n- **Mejora de descubribilidad**: Tiempo reducido para encontrar información específica\n- **Facilidad de mantenimiento**: Esfuerzo reducido para actualizaciones futuras\n\n## Plantilla para Análisis de Consolidación\n\n### Comparación de Skills\n\n| Aspecto | Skill A | Skill B | Skill C | Observaciones |\n|---------|---------|---------|---------|---------------|\n| Descripción | [texto] | [texto] | [texto] | ¿Solapamiento temático? |\n| Tags | [lista] | [lista] | [lista] | ¿Taxonomía común? |\n| Herramientas Cubiertas | [lista] | [lista] | [lista] | ¿Solapamiento significativo? |\n| Metodología | [descripción] | [descripción] | [descripción] | ¿Mismo enfoque? |\n| Procedimientos Clave | [lista] | [lista] | [lista] | ¿Pasos similares? |\n| Casos de Uso | [lista] | [lista] | [lista] | ¿Subconjunto o superconjunto? |\n| Contenido Único | [descripción] | [descripción] | [descripción] | ¿Qué debe preservarse? |\n\n### Plan de Migración\n\n| Contenido | Source Skill | Destino en Skill Consolidado | Ubicación en References/ |\n|-----------|--------------|------------------------------|--------------------------|\n| [descripción] | Skill A | Sección X, Subsección Y | references/tema-especifico.md |\n| [descripción] | Skill B | Sección X, Subsección Z | (integrado en sección principal) |\n| [descripción] | Skill C | No migrar (obsoleto) | N/A |\n\n---\n\n## Referencias Cruzadas\n\n- `hermes-agent-skill-authoring`: Para la creación y estructura de skills nuevos\n- `hermes-agent`: Para configuración y extensión del agente Hermes\n- `cybersecurity-consulting`: Metodología de consultoría que puede beneficiarse de portfolio management\n- `user-interaction-style`: Guía para interactuar efectivamente con el usuario durante el proceso\n\n## Historial de Cambios\n\n- v1.0.0: Creación inicial basada en la metodología desarrollada para revisar y consolidar skills de pentesting, consultoría y seguridad de red Fortinet.\n- v1.1.0: Adición de directrices específicas para manejar inconsistencias de nomenclatura (prefijos/suffijos), skills sin categorizar y referencias a skills inexistentes, basado en experiencia de consolidación de skills de ciberseguridad y BRIDA IT Services.\n\n> **Nota**: Esta skill fue creada como resultado de una sesión de revisión de portfolio donde se identificaron oportunidades significativas de consolidación en múltiples dominios. Aplica los principios descritos aquí para mantener un ecosistema de skills eficiente y no redundante.\n```
# Skill Name — BRIDA IT Services

## Descripción General
[Alcance amplio que cubra múltiples casos de uso específicos]

## Cuándo Usar Este Skill
[Guía para determinar cuándo aplicar este skill consolidado]

## Secciones Principales

### Sección 1: [Tema Amplio 1]
- Contenido que antes estaba en Skill A, Subtema X
- Contenido que antes estaba en Skill B, Subtema Y
- [etc.]

### Sección 2: [Tema Amplio 2]
- Contenido que antes estaba en Skill A, Subtema Z
- Contenido que antes estaba en Skill C, Subtema W
- [etc.]

## Referencias y Soporte

### Directorio `references/`
- `references/tema-especifico-a.md`: Detalles que antes estaban en Skill A
- `references/tema-especifico-b.md`: Detalles que antes estaban en Skill B
- [etc.]

### Directorio `templates/`
- Plantillas reutilizables extraídas de los skills originales

### Directorio `scripts/`
- Scripts de verificación, configuración o automatización

## Flujo de Trabajo Típico

1. [Paso inicial común]
2. [Ramificación basada en necesidad específica]
3. [Procedimientos detallados en referencias si se necesita profundidad]
4. [Conclusión y próximos pasos]

## Beneficios de la Consolidación

- **Reducción de redundancia**: Menos duplicación de contenido
- **Mejor descubrimiento**: Más fácil encontrar la información relevante
- **Mantenimiento simplificado**: Actualizaciones en un solo lugar
- **Coherencia mejorada**: Enfoque y terminología consistentes
- **Context preservation**: Detalles específicos aún disponibles en references/

## Trampas Comunes a Evitar

- **Sobre-generalización**: Hacer el skill demasiado amplio para ser útil
- **Pérdida de especificidad**: Eliminar detalles críticos que eran importantes en contexts específicos
- **Estructura confusa**: No organizar claramente el contenido para navegación fácil
- **Referencias inadequadas**: No proporcionar suficiente detalle en el directorio de referencias

## Flujo de Trabajo de Consolidación (Ejemplo)

```bash
# 1. Obtener lista de skills
skills_list()

# 2. Identificar candidatos para consolidación (ej: habilidades de pentesting)
# 3. Ver contenido de cada skill
skill_view(name='pentest-arsenal-brida')
skill_view(name='pentest-tool-installation')
skill_view(name='pentesting-arsenal')

# 4. Analizar solapamientos y diferencias
# 5. Diseñar estructura consolidada
# 6. Crear nuevo skill
skill_manage(action='create', name='pentesting-brida', content='[SKILL.md completo]')

# 7. Añadir archivos de soporte
skill_manage(action='write_file', name='pentesting-brida', file_path='references/coverage-analysis.md', content='[contenido]')
skill_manage(action='write_file', name='pentesting-brida', file_path='templates/installation-pattern.md', content='[plantilla]')

# 8. Validar y documentar
# ...
```

## Métricas de Éxito

- **Reducción de skills**: % de skills consolidados sin pérdida de funcionalidad
- **Preservación de conocimiento**: % de contenido útil único mantenido
- **Mejora de descubribilidad**: Tiempo reducido para encontrar información específica
- **Facilidad de mantenimiento**: Esfuerzo reducido para actualizaciones futuras

## Plantilla para Análisis de Consolidación

### Comparación de Skills

| Aspecto | Skill A | Skill B | Skill C | Observaciones |
|---------|---------|---------|---------|---------------|
| Descripción | [texto] | [texto] | [texto] | ¿Solapamiento temático? |
| Tags | [lista] | [lista] | [lista] | ¿Taxonomía común? |
| Herramientas Cubiertas | [lista] | [lista] | [lista] | ¿Solapamiento significativo? |
| Metodología | [descripción] | [descripción] | [descripción] | ¿Mismo enfoque? |
| Procedimientos Clave | [lista] | [lista] | [lista] | ¿Pasos similares? |
| Casos de Uso | [lista] | [lista] | [lista] | ¿Subconjunto o superconjunto? |
| Contenido Único | [descripción] | [descripción] | [descripción] | ¿Qué debe preservarse? |

### Plan de Migración

| Contenido | Source Skill | Destino en Skill Consolidado | Ubicación en References/ |
|-----------|--------------|------------------------------|--------------------------|
| [descripción] | Skill A | Sección X, Subsección Y | references/tema-especifico.md |
| [descripción] | Skill B | Sección X, Subsección Z | (integrado en sección principal) |
| [descripción] | Skill C | No migrar (obsoleto) | N/A |

---

## Referencias Cruzadas

- `hermes-agent-skill-authoring`: Para la creación y estructura de skills nuevos
- `hermes-agent`: Para configuración y extensión del agente Hermes
- `cybersecurity-consulting`: Metodología de consultoría que puede beneficiarse de portfolio management
- `user-interaction-style`: Guía para interactuar efectivamente con el usuario durante el proceso

## Historial de Cambios

- v1.0.0: Creación inicial basada en la metodología desarrollada para revisar y consolidar skills de pentesting, consultoría y seguridad de red Fortinet.

> **Nota**: Esta skill fue creada como resultado de una sesión de revisión de portfolio donde se identificaron oportunidades significativas de consolidación en múltiples dominios. Aplica los principios descritos aquí para mantener un ecosistema de skills eficiente y no redundante.