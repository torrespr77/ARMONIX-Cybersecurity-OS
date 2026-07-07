---
name: threat-modeling-BRIDA
description: Threat Modeling profesional para consultoría de ciberseguridad — metodología STRIDE + DREAD + MITRE ATT&CK, adaptada al stack BRIDA IT y clientes mexicanos medianos.
---

# 🎯 Threat Modeling — Metodología BRIDA IT

## Propósito
Crear Threat Models profesionales como base para propuestas de ciberseguridad. Documento técnico-ejecutivo que identifica amenazas, prioriza riesgos y sirve como fundamento para la propuesta comercial.

## Metodología: STRIDE + DREAD + MITRE ATT&CK

### Paso 1: Recopilación de Información
**Fuentes:**
- OSINT (DNS, WHOIS, SSL, Shodan, Censys)
- Entrevista con el cliente (CIO, TI, operaciones)
- Diagrama de red (si existe)
- Inventario de activos (si existe)
- Políticas de seguridad (si existen)

**Herramientas OSINT:**
```bash
# DNS
dig +short <dominio>
dig MX <dominio>
dig TXT <dominio>  # Buscar SPF/DKIM/DMARC

# WHOIS
whois <dominio>

# SSL
openssl s_client -connect <dominio>:443 -servername <dominio>

# Tecnología web
curl -I https://<dominio>  # Headers
# Usar Wappalyzer o BuiltWith

# Shodan (si hay API key)
shodan host <IP>
```

### Paso 2: Identificación de Activos
| Categoría | Ejemplos |
|---|---|
| **Datos** | PII clientes, datos financieros, credenciales, CFDI |
| **Aplicaciones** | ERP, POS, e-commerce, facturación, email |
| **Infraestructura** | Servidores, firewalls, switches, APs |
| **Endpoints** | Laptops, desktops, móviles, tablets |
| **Red** | LAN, WAN, VPN, WiFi, internet |
| **Personas** | Empleados, proveedores, clientes |
| **Procesos** | Pagos, facturación, inventario, RRHH |

### Paso 3: STRIDE — Categorías de Amenaza

| Letra | Amenaza | Descripción | Ejemplo para Grupo Pepe |
|---|---|---|---|
| **S** | Spoofing | Suplantación de identidad | Email falso de proveedor para fraude |
| **T** | Tampering | Modificación no autorizada | Alteración de precios en POS |
| **R** | Repudiation | Negación de acciones | Empleado niega haber borrado datos |
| **I** | Information Disclosure | Filtración de información | Base de datos de clientes expuesta |
| **D** | Denial of Service | Denegación de servicio | DDoS contra ordena.pollopepe.com |
| **E** | Elevation of Privilege | Escalamiento de privilegios | Empleado accede a datos de admin |

### Paso 4: DREAD — Scoring de Riesgo

| Criterio | Puntuación (1-10) | Descripción |
|---|---|---|
| **D**amage | 1-10 | ¿Cuánto daño causa? |
| **R**eproducibility | 1-10 | ¿Qué tan fácil es reproducir? |
| **E**xploitability | 1-10 | ¿Qué tan fácil es explotar? |
| **A**ffected Users | 1-10 | ¿Cuántos usuarios afecta? |
| **D**iscoverability | 1-10 | ¿Qué tan fácil es descubrir? |

**Fórmula:** Riesgo = (D + R + E + A + D) / 5

| Rango | Severidad | Color |
|---|---|---|
| 8-10 | 🔴 CRÍTICO | Rojo |
| 6-7.9 | 🟠 ALTO | Naranja |
| 4-5.9 | 🟡 MEDIO | Amarillo |
| 1-3.9 | 🟢 BAJO | Verde |

### Paso 5: Mapeo MITRE ATT&CK
Para cada amenaza STRIDE, mapear a tácticas/técnicas ATT&CK relevantes:

| Amenaza | Táctica ATT&CK | Técnica | ID |
|---|---|---|---|
| Phishing | Initial Access | Spearphishing Attachment | T1566.001 |
| Ransomware | Impact | Data Encrypted for Impact | T1486 |
| Credential Theft | Credential Access | Credential Dumping | T1003 |
| Lateral Movement | Lateral Movement | Remote Services | T1021 |
| Data Exfiltration | Exfiltration | Exfiltration Over C2 | T1041 |
| Privilege Escalation | Privilege Escalation | Valid Accounts | T1078 |
| Persistence | Persistence | Registry Run Keys | T1547.001 |
| Defense Evasion | Stealth | Masquerading | T1036 |

### Paso 6: Escenarios de Ataque
Crear 3-5 escenarios narrativos detallados:

**Formato de escenario:**
1. **Título:** Nombre del ataque
2. **Actor:** Quién ataca (externo, interno, proveedor)
3. **Vector:** Cómo entra (phishing, web, físico, supply chain)
4. **Narrativa:** Paso a paso del ataque (timeline)
5. **Impacto:** Qué se compromete y cuánto cuesta
6. **Probabilidad:** Alta/Media/Baja
7. **Mitigación BRIDA:** Qué herramienta/servicio lo previene

### Paso 7: Recomendaciones por Fase

**Quick Wins (0-30 días) — $:**
- Configurar SPF/DKIM/DMARC
- Habilitar MFA en todos los accesos
- Parches críticos (Qualys)
- Backup verificado
- Políticas de contraseñas

**Corto Plazo (1-3 meses) — $$:**
- FortiGate NGFW
- CrowdStrike EDR
- Qualys Vulnerability Management
- Segmentación de red
- WiFi seguro (WPA3)

**Mediano Plazo (3-6 meses) — $$$:**
- FortiSASE / Zero Trust
- SIEM / Monitoreo 24x7
- DLP (Data Loss Prevention)
- Capacitación de usuarios
- Incident Response Plan

**Largo Plazo (6-12 meses) — $$$$:**
- SOC (interno o MSSP)
- Red Team / Purple Team exercises
- ISO 27001 / NIST CSF compliance
- BCP / DRP
- Threat Intelligence program

## Formato del Documento Final

### Estructura del Threat Model (Word/PDF)
1. **Portada** — Logos, título, fecha, versión, confidencial
2. **Tabla de Contenido**
3. **Resumen Ejecutivo** (1 página, para CIO)
4. **Alcance del Engagement**
5. **Perfil del Cliente** (OSINT)
6. **Diagrama de Red** (si disponible)
7. **Inventario de Activos**
8. **Superficie de Ataque**
9. **Matriz STRIDE + DREAD** (tabla completa)
10. **Top 10 Amenazas** (priorizadas)
11. **Escenarios de Ataque** (3-5 narrativas)
12. **Mapeo MITRE ATT&CK** (referencia técnica)
13. **Recomendaciones por Fase**
14. **Hoja de Ruta** (timeline visual)
15. **Glosario**
16. **Control de Versiones**

## Herramientas de Diagramación
- **draw.io / diagrams.net** — Diagramas de red y arquitectura
- **Miro / Lucidchart** — Threat model visual
- **Python (matplotlib/graphviz)** — Generación automática de diagramas
- **Excalidraw** — Diagramas rápidos estilo hand-drawn

## Referencias
- Microsoft Threat Modeling Tool (STRIDE)
- OWASP Threat Dragon
- MITRE ATT&CK Navigator (attack.mitre.org)
- NIST SP 800-30 (Guide for Conducting Risk Assessments)
