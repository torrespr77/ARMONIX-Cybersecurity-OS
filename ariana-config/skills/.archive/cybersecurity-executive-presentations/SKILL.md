---
name: cybersecurity-executive-presentations
description: "Genera presentaciones ejecutivas de ciberseguridad para CEO, CISO, CIO e IT Support Teams. Incluye guías de lenguaje, estructura de slides, y templates adaptados a cada audiencia en el contexto de consultoría BRIDA IT Services."
---

# 🎯 Cybersecurity Executive Presentations

## Cuándo usar este skill

Usa este skill cuando necesites crear presentaciones de ciberseguridad para:
- **CEO / Director General** — Enfoque en negocio, riesgo financiero, continuidad operativa
- **CISO / CTO** — Enfoque técnico-estratégico, arquitectura, roadmap de seguridad
- **CIO** — Enfoque en infraestructura, presupuesto, ROI de seguridad
- **IT Support Team** — Enfoque operativo, procedimientos, herramientas, quick wins

## ⚠️ PRIMERO: Cargar el skill `powerpoint`

**SIEMPRE** carga el skill `powerpoint` antes de generar cualquier presentación. Contiene las guías completas de diseño, layout, paletas de color, QA y scripts de conversión.

```
skill_view(name='powerpoint')
```

---

## 🎭 Guía de Audiencias

### 👔 CEO / Director General

**Lo que les importa:**
- ¿Cuánto dinero podemos perder?
- ¿Se puede seguir operando?
- ¿Hay riesgo legal o regulatorio?
- ¿Cuánto cuesta arreglarlo vs. no hacer nada?

**Lo que NO les importa:**
- Detalles técnicos de CVEs
- Nombres de herramientas específicas
- Configuraciones de firewall

**Lenguaje:**
- ❌ "Se encontraron 47 vulnerabilidades CVSS 9.8 en el perímetro"
- ✅ "Detectamos que un atacante podría entrar a nuestros sistemas críticos y paralizar las operaciones de las 190 sucursales. El impacto estimado es de $XM MXN en pérdidas."

**Estructura recomendada (8-10 slides):**
1. Título (BRIDA + cliente + fecha)
2. Resumen ejecutivo (3 bullets máximo)
3. Contexto del negocio (tamaño, presencia, operación)
4. ¿Qué encontramos? (visual, sin tecnicismos)
5. Impacto financiero (tabla: escenario vs. costo)
6. ¿Qué pasa si NO hacemos nada? (costo de inacción)
7. Nuestra recomendación (3-5 acciones claras)
8. Inversión estimada (tabla simple por fases)
9. Próximos pasos (3 acciones inmediatas)
10. Contacto BRIDA

**Paleta de colores:** Midnight Executive (`1E2761` navy + `CADCFC` ice blue + `FFFFFF` white)

---

### 🔐 CISO / CTO

**Lo que les importa:**
- Threat landscape y TTPs específicos
- Gaps de arquitectura y cómo cerrarlos
- Roadmap de madurez de seguridad
- Métricas y KPIs de seguridad
- Compliance (NIST, ISO 27001, PCI-DSS)

**Lenguaje:**
- Mezcla de negocio + técnico
- Usa frameworks: "Según NIST CSF, estamos en nivel Tier 1 (Partial) en Identify y Protect"
- Menciona herramientas: "Recomendamos FortiGate + FortiSASE para Zero Trust"

**Estructura recomendada (12-15 slides):**
1. Título
2. Resumen ejecutivo
3. Perfil del cliente (OSINT, infraestructura)
4. Metodología (STRIDE + DREAD + MITRE ATT&CK)
5. Superficie de ataque (diagrama visual)
6. Hallazgos críticos 1-3 (con evidencia)
7. Hallazgos críticos 4-6 (con evidencia)
8. Matriz de amenazas (top 10)
9. Mapeo MITRE ATT&CK (heat map)
10. Arquitectura objetivo (diagrama)
11. Hoja de ruta de madurez (fases)
12. Quick wins (0-30 días)
13. Inversión por fase
14. Métricas de éxito (KPIs)
15. Próximos pasos + contacto

**Paleta de colores:** Teal Trust (`028090` teal + `00A896` seafoam + `02C39A` mint)

---

### 💻 CIO

**Lo que les importa:**
- Impacto en la operación diaria
- Presupuesto y ROI
- Integración con infraestructura existente
- Tiempo de implementación
- Recursos humanos necesarios

**Lenguaje:**
- Enfocado en infraestructura y operación
- "La implementación de FortiGate no requiere cambiar la topología actual"
- "El VA se realiza sin impacto en la operación"

**Estructura recomendada (10-12 slides):**
1. Título
2. Contexto de infraestructura actual
3. Hallazgos principales (impacto operativo)
4. Arquitectura actual vs. objetivo
5. Fases de implementación (timeline)
6. Requerimientos de infraestructura
7. Impacto en operación por fase
8. Presupuesto detallado
9. ROI y TCO
10. Riesgos de no actuar
11. Próximos pasos
12. Contacto

**Paleta de colores:** Charcoal Minimal (`36454F` charcoal + `F2F2F2` off-white + `212121` black)

---

### 🔧 IT Support Team

**Lo que les importa:**
- ¿Qué tengo que hacer HOY?
- Procedimientos paso a paso
- Herramientas que van a usar
- Cómo reportar incidentes
- Capacitación disponible

**Lenguaje:**
- Directo, práctico, sin ambigüedades
- "Paso 1: Instalar el agente de CrowdStrike en todos los endpoints"
- "Si ves esto, reporta inmediatamente al canal #security"

**Estructura recomendada (8-10 slides):**
1. Título + objetivo de la sesión
2. ¿Qué está pasando? (contexto simple)
3. ¿Qué cambia para ustedes? (lo nuevo)
4. Procedimientos nuevos (paso a paso con screenshots)
5. Herramientas nuevas (guía rápida)
6. Cómo reportar incidentes (flujo visual)
7. Contactos de seguridad (quién es quién)
8. FAQ
9. Capacitación programada
10. Q&A

**Paleta de colores:** Forest & Moss (`2C5F2D` forest + `97BC62` moss + `F5F5F5` cream)

---

## 📐 Diseño Universal (Todas las audiencias)

### Tipografía
| Elemento | Fuente | Tamaño |
|---|---|---|
| Títulos | Georgia Bold o Arial Black | 36-44pt |
| Headers | Georgia o Arial | 20-24pt |
| Body | Calibri o Arial | 14-16pt |
| Captions | Calibri Light | 10-12pt |

### Reglas de oro
- **UN mensaje por slide** — si necesitas más texto, son 2 slides
- **Visual > Texto** — usa diagramas, iconos, gráficos
- **Severidad con color:** 🔴 CRÍTICO | 🟠 ALTO | 🟡 MEDIO | 🟢 BAJO
- **Sin walls of text** — máximo 5-6 bullets por slide
- **Branding BRIDA** en todas las slides (logo, colores, datos de contacto)

### Iconos útiles por audiencia
| Audiencia | Iconos |
|---|---|
| CEO | 💰📉🏢⚖️🚨 |
| CISO | 🔐🛡️🎯📊🔍 |
| CIO | 💻🔄📡⚙️📈 |
| IT Support | 🔧📋✅❌🆘 |

---

## 🔄 Proceso de Generación

1. **Identificar audiencia** — ¿CEO, CISO, CIO, IT Support?
2. **Cargar skill `powerpoint`** — Diseño y QA
3. **Seleccionar paleta** — Según audiencia
4. **Generar contenido** — Con lenguaje adaptado
5. **Crear slides** — Con python-pptx o pptxgenjs
6. **QA visual** — Convertir a imágenes y revisar
7. **QA de contenido** — Extraer texto y verificar
8. **Entregar** — .pptx + PDF

---

## 📁 Templates BRIDA

Cuando generes presentaciones, incluye en la última slide:

```
BRIDA IT Services
🔐 Cybersecurity Consulting
📧 roger@bridaitservices.com
🌐 www.bridaitservices.com
👤 Roger Torres Pimentel — Consultor de Ciberseguridad
👤 Bernardo Gomez — Gerente / Líder de Proyecto
```

---

## 🎨 Paleta BRIDA (Branding)

| Uso | Color | Hex |
|---|---|---|
| Primary | Navy BRIDA | `1B1464` |
| Secondary | Gris oscuro | `4A4A4A` |
| Danger/Riesgo | Rojo | `CC0000` |
| Success/Solución | Verde | `00AA00` |
| Warning | Naranja | `FF8800` |
| Info | Azul | `0066CC` |
| Background claro | Blanco | `FFFFFF` |
| Background oscuro | Negro suave | `1A1A2E` |
