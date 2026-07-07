---
name: cybersecurity-presentations
description: Guía para crear presentaciones efectivas de propuestas de ciberseguridad para diferentes audiencias (CEO, CISO, IT) en el contexto de BRIDA IT Services.
---

# Skill: Presentaciones de Ciberseguridad — BRIDA IT Services

## Descripción
Guía para crear presentaciones efectivas de propuestas de ciberseguridad para diferentes audiencias: CEO, CISO, y equipo IT.

## Principio Clave
**Cada audiencia habla un idioma diferente.** Adaptar el mensaje es tan importante como el contenido.

---

## 🎯 NIVEL CEO / DIRECTOR GENERAL

### Mentalidad del CEO
- "¿Cuánto cuesta? ¿Cuánto riesgo reduzco? ¿Cuándo veo ROI?"
- No le importa la técnica, el impacto en el negocio
- Quiere números claros: $, %, tiempo
- Decisiones rápidas, slides limpios

### Estructura de Presentación CEO (15-20 min)
1. **Portada** — Propuesta + Cliente + BRIDA IT + Fecha
2. **El Problema** (2 min) — "Su empresa tiene X vulnerabilidades críticas que podrían costar $Y MXN"
3. **Riesgo de Negocio** (3 min) — Escenarios de impacto financiero (ransomware = $X, downtime = $Y/día)
4. **Nuestra Solución** (5 min) — Visión general del stack (Fortinet, Qualys, CrowdStrike, etc.)
5. **Inversión y ROI** (3 min) — Tabla comparativa: costo de inversión vs costo de un incidente
6. **Plan de Implementación** (3 min) — Fases con timeline visual
7. **Cierre** — Call to action claro

### Lenguaje CEO
- ✅ "Reducción del 85% en riesgo de ransomware"
- ✅ "Inversión de $X MXN vs pérdida potencial de $Y MXN"
- ✅ "ROI positivo en 6 meses"
- ✅ "Continuidad del negocio garantizada"
- ❌ "Implementaremos un FortiGate 60F con IPS/IDS habilitado"

### Formato Visual
- Colores corporativos del cliente
- Gráficos de barras/pastel (no tablas técnicas)
- Máximo 6-8 slides
- Una idea por slide
- Iconos grandes, texto mínimo

---

## 🔐 NIVEL CISO / GERENTE DE SEGURIDAD

### Mentalidad del CISO
- "¿Cómo se integra con mi stack actual? ¿Qué cubre exactamente?"
- Quiere detalle técnico pero ejecutivo
- Le importa compliance, frameworks, métricas
- Evalúa si la solución resuelve sus gaps específicos

### Estructura de Presentación CISO (30-45 min)
1. **Portada y Agenda**
2. **Resumen Ejecutivo** — Hallazgos clave del assessment
3. **Threat Landscape** — Amenazas específicas al sector/empresa
4. **Gap Analysis** — Estado actual vs estado deseado (NIST CSF / CIS Controls)
5. **Arquitectura Propuesta** — Diagrama de red con stack BRIDA
6. **Detalle por Solución:**
   - Perimetral (FortiGate + FortiSASE)
   - Endpoint (CrowdStrike / Trellix)
   - Vulnerability Management (Qualys)
   - Email Security (SPF/DKIM/DMARC + sandboxing)
   - Cloud (AWS security)
7. **Threat Model** — Top amenazas con scoring DREAD/CVSS
8. **Plan de Implementación** — Fases detalladas con responsables
9. **KPIs y Métricas** — Cómo medir el éxito
10. **Inversión** — Desglose por solución
11. **Anexos** — MITRE ATT&CK mapping, detalles técnicos

### Lenguaje CISO
- ✅ "FortiGate con SSL Inspection y IPS integrado"
- ✅ "Qualys VMDR para continuous vulnerability management"
- ✅ "CrowdStrike Falcon para EDR con threat intelligence"
- ✅ "DMARC policy progression: none → quarantine → reject"
- ✅ "Zero Trust Network Access via FortiSASE"
- ❌ "Le ponemos un antivirus" (decir: "EDR de próxima generación")

### Formato Visual
- Diagramas de arquitectura de red
- Tablas comparativas de soluciones
- Matrices de riesgo (heat maps)
- 15-25 slides
- Incluir anexos técnicos

---

## 💻 NIVEL EQUIPO IT / SOPORTE TÉCNICO

### Mentalidad del IT Team
- "¿Cómo se instala? ¿Qué tengo que configurar? ¿Me va a generar más trabajo?"
- Quiere procedimientos paso a paso
- Le preocupa la complejidad operativa
- Necesita saber exactamente qué hacer

### Estructura de Presentación IT (45-60 min + Q&A)
1. **Portada y Objetivo del Taller**
2. **Arquitectura General** — Diagrama de red simplificado
3. **Configuración Paso a Paso por Solución:**
   - FortiGate: reglas básicas, VPN, segmentación
   - CrowdStrike/Trellix: instalación de agentes, dashboard
   - Qualys: escaneo inicial, interpretación de reportes
   - SPF/DKIM/DMARC: registros DNS exactos
   - Active Directory: estructura OU, GPOs básicas
4. **Procedimientos Operativos:**
   - Cómo responder a una alerta
   - Cómo revisar reportes de Qualys
   - Cómo manejar incidentes de phishing
5. **Troubleshooting Común**
6. **Contacto y Soporte BRIDA**
7. **Q&A**

### Lenguaje IT
- ✅ "Paso 1: Acceder a Cloudflare > DNS > Add Record"
- ✅ "Instalar el agente de CrowdStrike con este comando: ..."
- ✅ "Configurar el FortiGate con estas políticas de firewall"
- ✅ "El registro TXT debe verse así: v=spf1 include:_spf.google.com ~all"
- ❌ "Implementar una estrategia integral de ciberseguridad"

### Formato Visual
- Screenshots reales de las herramientas
- Comandos exactos en bloques de código
- Diagramas de flujo (flowcharts)
- Checklists de verificación
- 20-40 slides con mucho detalle

---

## 📐 FORMATO Y BRANDING

### Autor y Contacto (vigente desde 18 Jun 2026)
- **Autor:** Ing. Rogelio Torres Pimentel — Senior Cybersecurity Consultant / Architect
- **Datos de contacto:**
  - LinkedIn: https://www.linkedin.com/in/rogeliotorres/
  - Email: rogelio.torres.pimentel@gmail.com
  - Móvil: +52 33 1486 9253
- **Sin referencias a BRIDA IT Services** — No incluir nombre, logo, URL ni mención alguna

### Herramientas de Creación
- **PowerPoint/Google Slides** — Presentaciones ejecutivas
- **Word (.docx)** — Documentos técnicos detallados
- **PDF** — Entregables finales
- **Excalidraw/diagrams.net** — Diagramas de arquitectura
- **Canva** — Infografías y material visual

### Tips de Diseño
- Fuentes: Arial, Calibri, o Montserrat
- Tamaño mínimo: 18pt cuerpo, 24pt+ títulos
- Contraste alto
- Máximo 6 puntos por slide
- Incluir página de "Notas" con guía para el presentador

---

## Lecciones Aprendidas (Self-Improvement Jun 2026)

1. **Tres audiencias, tres idiomas** — Nunca mezclar niveles. CEO = $. CISO = arquitectura. IT = comandos.
2. **Formato Word para técnicos** — Los documentos técnicos detallados van en Word (.docx) editable, no solo PDF.
3. **Branding consistente** — Portada con BRIDA IT Services, footer en cada página, colores corporativos.
4. **Confirmar entrega** — Roger quiere confirmación explícita cuando cada tarea termina.

## Templates Disponibles

### Template 1: Propuesta Comercial (CEO)
- 8-12 slides | Enfoque en negocio y ROI | Entrega: PowerPoint + PDF

### Template 2: Propuesta Técnica (CISO)
- 20-30 slides | Arquitectura y soluciones | Entrega: PowerPoint + Word

### Template 3: Guía de Implementación (IT)
- 30-50 slides | Procedimientos paso a paso | Entrega: Word + PDF

### Template 4: Threat Model Report
- Documento Word completo | Metodología STRIDE+DREAD | Escenarios de ataque | Entrega: Word editable + PDF
