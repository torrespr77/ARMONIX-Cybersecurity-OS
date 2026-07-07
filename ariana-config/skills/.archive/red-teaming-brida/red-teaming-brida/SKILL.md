---
name: red-teaming-brida
description: 'Red Team operations and adversary simulation for BRIDA IT Services clients. Covers full-scope red team engagements, Active Directory attacks, phishing simulations, lateral movement, C2 infrastructure, and purple team exercises. Activates for: red team, adversary simulation, AD attack, phishing simulation, purple team, C2, lateral movement.'
domain: cybersecurity
subdomain: red-teaming
tags:
- red-team
- adversary-simulation
- active-directory
- phishing-simulation
- purple-team
- C2
- lateral-movement
version: 1.0.0
author: BRIDA IT Services (adapted from mukul975/Anthropic-Cybersecurity-Skills)
license: Apache-2.0
nist_csf:
- DE.DP-01
- DE.AE-07
- PR.AT-01
mitre_attack:
- T1078
- T1059
- T1021
- T1566
- T1003
---

# Red Teaming — BRIDA IT Services

## Descripción
Operaciones de Red Team y simulación de adversarios para clientes de BRIDA IT Services. Cubre engagements full-scope, ataques a Active Directory, simulaciones de phishing, movimiento lateral, infraestructura C2 y ejercicios purple team.

## Cuándo Usar
- Evaluación de capacidades de detección y respuesta del SOC
- Simulación de amenazas persistentes avanzadas (APT)
- Pruebas de controles de seguridad end-to-end
- Validación de planes de respuesta a incidentes
- Ejercicios de Purple Team

## Pre-requisitos Críticos
- **ROE (Rules of Engagement)** firmado por el cliente
- **Get out of jail free card** — Contacto de emergencia 24/7
- **Scope document** — Qué está en scope y qué NO
- **White cell** — Persona de contacto que sabe del ejercicio
- **Stop conditions** — Cuándo detener el ejercicio inmediatamente

## Metodología Red Team

### Fase 1: Pre-Engagement
```
1. Definir objetivos del ejercicio (ej: "Comprometer el dominio AD")
2. Establecer ROE y scope
3. Configurar infraestructura C2
4. Preparar payloads y herramientas
5. Coordinar con White Cell
6. Establecer canales de comunicación seguros
```

### Fase 2: Reconnaissance
```
OSINT:
- LinkedIn (empleados, tecnologías, estructura)
- Shodan/Censys (servicios expuestos)
- DNS enumeration
- Email harvesting (theHarvester)
- Technology stack identification

Herramientas:
- theHarvester, Recon-ng, Maltego, Shodan, Censys
```

### Fase 3: Initial Access
```
Vectores:
1. Phishing (spearphishing, credential harvesting)
2. Exposed services (RDP, VPN, web apps)
3. Supply chain compromise
4. Physical access (USB drops, tailgating)
5. Watering hole attacks

Herramientas:
- GoPhish (phishing framework)
- Evilginx2 (credential harvesting)
- Metasploit (exploitation)
- Burp Suite (web app attacks)
```

### Fase 4: Persistence
```
Técnicas:
1. Backdoor accounts
2. Scheduled tasks
3. WMI event subscriptions
4. Registry run keys
5. DLL hijacking
6. Golden/Silver Tickets (AD)
7. DCShadow (AD)
8. Skeleton Key (AD)

Herramientas:
- Mimikatz, Rubeus, SharpHound, PowerView
```

### Fase 5: Privilege Escalation
```
Active Directory:
- Kerberoasting (T1558.003)
- AS-REP Roasting (T1558.004)
- DCSync (T1003.006)
- Token impersonation
- Unconstrained delegation
- Resource-based constrained delegation
- ACL abuse (GenericAll, WriteDACL)

Local:
- Token manipulation
- Service exploitation
- Kernel exploits
- Credential dumping

Herramientas:
- Rubeus, Impacket, BloodHound, PowerView, Certify
```

### Fase 6: Lateral Movement
```
Técnicas:
- PsExec, WMI, WinRM, RDP
- Pass-the-Hash (PtH)
- Pass-the-Ticket (PtT)
- Overpass-the-Hash
- DCOM execution
- SSH tunneling

Herramientas:
- Impacket (psexec, wmiexec, smbexec)
- CrackMapExec
- Ligolo-ng (tunneling)
```

### Fase 7: Collection & Exfiltration
```
Objetivos típicos:
- Active Directory database (NTDS.dit)
- Source code repositories
- Customer databases
- Financial records
- Email archives
- Credential stores

Exfiltration:
- DNS tunneling
- HTTPS to cloud storage
- Steganography
- Encrypted channels (C2)
```

## Active Directory Attack Paths

### Attack Path 1: Kerberoasting → Domain Admin
```
1. Enumerar SPNs (Service Principal Names)
   Get-DomainUser -SPN | Select samaccountname

2. Solicitar TGS tickets para cuentas de servicio
   Rubeus kerberoast /outfile:hashes.txt

3. Crackear offline
   hashcat -m 13100 hashes.txt wordlist.txt

4. Si la cuenta de servicio tiene privilegios → Escalar
   → DCSync → Domain Admin
```

### Attack Path 2: Phishing → Credential Harvest → Lateral Movement
```
1. Enviar phishing con enlace a falso login
2. Capturar credenciales con Evilginx2
3. Usar credenciales para acceder a VPN/email
4. Enumerar AD desde dentro (BloodHound)
5. Encontrar camino a Domain Admin
6. Mover lateralmente con las credenciales
```

### Attack Path 3: AS-REP Roasting → Privilege Escalation
```
1. Encontrar cuentas con "Don't require Kerberos preauth"
   Get-DomainUser -UAC DONT_REQ_PREAUTH

2. Solicitar AS-REP sin contraseña
   Rubeus asreproast /outfile:hashes.txt

3. Crackear offline
   hashcat -m 18200 hashes.txt wordlist.txt

4. Usar credenciales para escalar
```

## C2 (Command & Control) Frameworks
| Framework | Tipo | Características |
|---|---|---|
| Cobalt Strike | Comercial | Industry standard, malleable C2 |
| Sliver | Open Source | Modern, implant generation |
| Havoc | Open Source | Post-exploitation framework |
| Mythic | Open Source | Multi-agent, modular |
| Brute Ratel | Comercial | Evasión EDR |

## Phishing Simulation
```
Herramienta: GoPhish (https://getgophish.com)

Proceso:
1. Crear landing page (clon de login corporativo)
2. Configurar email template (spearphishing)
3. Definir grupo de objetivos
4. Lanzar campaña
5: Métricas:
   - Open rate
   - Click rate
   - Credential submission rate
   - Report rate (usuarios que reportan)
6. Reporte con métricas y recomendaciones
```

## Purple Team Exercises
```
Objetivo: Validar detecciones específicas

Proceso:
1. Red Team ejecuta técnica específica
2. Blue Team verifica si la detecta
3. Si no se detecta → Crear regla de detección
4. Re-test para validar la nueva regla
5. Documentar lecciones aprendidas

Ejercicios por MITRE ATT&CK:
- T1003 (Credential Dumping) → ¿Detecta Mimikatz?
- T1059 (PowerShell) → ¿Detecta scripts sospechosos?
- T1021 (Remote Services) → ¿Detecta lateral movement?
- T1566 (Phishing) → ¿Detecta URLs maliciosas?
```

## Entregables Red Team
1. **Executive Summary** — Impacto de negocio, narrativa del ataque
2. **Attack Narrative** — Paso a paso del ataque con timeline
3. **Findings Report** — Cada hallazgo con evidencia y remediación
4. **MITRE ATT&CK Mapping** — Técnicas utilizadas mapeadas
5. **Detection Gaps** — Qué no se detectó y cómo mejorar
6. **Remediation Roadmap** — Priorizado por impacto
