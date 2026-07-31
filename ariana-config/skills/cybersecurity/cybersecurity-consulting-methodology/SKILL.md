---
name: cybersecurity-consulting-methodology
description: "Complete cybersecurity consulting methodology for BRIDA IT Services — covering OSINT reconnaissance, threat modeling (STRIDE+DREAD), vulnerability assessment scoping, security architecture design, commercial proposals, and executive presentations for mid-market Mexican enterprises."
version: 3.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [cybersecurity, consulting, methodology, threat-model, proposals, presentations]
    related_skills: [pentesting-brida, powerpoint, docx]
---

# Cybersecurity Consulting — BRIDA IT Services Methodology

Complete framework for delivering professional cybersecurity consulting services to mid-market Mexican enterprises, integrating OSINT reconnaissance, threat modeling, risk assessment, security architecture design, and deliverable creation.

## 🎯 Overview

This skill consolidates the end-to-end cybersecurity consulting lifecycle for BRIDA IT Services, covering:
- Passive OSINT reconnaissance and attack surface mapping
- Threat modeling using STRIDE+DREAD (primary) with MITRE ATT&CK reference
- Vulnerability assessment scoping and VA→Threat Model integration
- Security architecture design (Fortinet, Zero Trust, Cloud)
- Commercial proposal development and executive presentations
- Deliverable creation with professional formatting (Word/PDF/PowerPoint)

## 👥 Target Client Profile

- **Size**: 500-5,000 employees
- **Sectors**: Retail, food/beverage, pharmaceuticals, services
- **Location**: Mexico (Jalisco, CDMX, Nuevo León, Monterrey)
- **Security Maturity**: Low to Medium
- **Budget**: Moderate, ROI-focused
- **Regulatory**: NOM, SAT (CFDI), possible PCI-DSS

## 🔧 BRIDA Tool Stack

| Category | Tool |
|----------|------|
| NGFW / Perimeter | Fortinet FortiGate |
| SASE / Zero Trust | FortiSASE |
| Vulnerability Management | Qualys VMDR |
| EDR / NGAV | CrowdStrike Falcon, Trellix ePO |
| WAF / CDN | Cloudflare |
| Pentesting | Kali Linux, Burp Suite, OWASP ZAP, Nmap, Nuclei, Metasploit |
| Cloud | AWS Security Hub, GuardDuty |
| Email Security | Google Workspace + SPF/DKIM/DMARC |
| SIEM | FortiAnalyzer, Splunk, Elastic |

## 📚 Reference Frameworks

- **MITRE ATT&CK v19.1** — Technical reference for TTPs
- **NIST CSF 2.0** — Maturity and governance assessment
- **STRIDE + DREAD** — Primary threat modeling methodology (client-facing)
- **OWASP Top 10 (2021)** — Web application security
- **PCI-DSS v4.0** — When handling cardholder data
- **ISO 27001:2022** — Information security management
- **CIS Controls v8** — Prioritized security controls

## 🔄 Engagement Lifecycle

### Phase 1: Passive OSINT Reconnaissance & Attack Surface Mapping
*Use when: Initial client engagement, pre-proposal assessment*

**Activities:**
1. **DNS & Email Security**
   - SPF, DKIM, DMARC validation
   - Nameserver and MX record analysis
   - Subdomain enumeration (passive via crt.sh, securitytrails)
   
2. **Web Technology Discovery**
   - CMS/framework identification (Wappalyer, BuiltWith)
   - Security headers analysis (HSTS, CSP, X-Frame-Options)
   - E-commerce platform detection (Magento, Shopify, WooCommerce)
   
3. **Organizational OSINT**
   - Leadership identification (LinkedIn, company site)
   - Employee count, locations, business model
   - Recent news, breaches, M&A activity
   - Technology stack from job postings
   
4. **Infrastructure Mapping**
   - Hosting provider identification
   - CDN detection (Cloudflare, Akamai, Fastly)
   - Cloud service usage (AWS, Azure, GCP indicators)
   - Remote access services (VPN, RDP, SSH exposure)

**Deliverable**: OSINT Reconnaissance Report (Word)
- Corporate profile table
- Infrastructure summary
- DNS/email security status (SPF/DKIM/DMARC)
- Key personnel identified
- Initial risk observations
- Recommended next steps

### Phase 2: Threat Modeling (STRIDE+DREAD)
*Use when: OSINT complete, ready to model threats*

**Methodology Confirmation**: Per Roger (2026-06-14), use **STRIDE+DREAD** as primary methodology with **MITRE ATT&CK** in annexes for technical depth.

**STRIDE Categories:**
- **S**poofing: Impersonation, authentication bypass
- **T**ampering: Unauthorized modification
- **R**epudiation: Lack of non-repudiation
- **I**nformation Disclosure: Data exposure, leakage
- **D**enial of Service: Service disruption, resource exhaustion
- **E**levation of Privilege: Unauthorized access escalation

**DREAD Scoring (1-10 scale):**
- **D**amage Potential: Financial, reputational, operational impact
- **R**eproducibility: Ease of reproduction
- **E**xploitability: Skill/resources required
- **A**ffected Users: % of user base impacted
- **D**iscoverability: Likelihood of discovery/attribution

**Process:**
1. Create network/application diagram with data flows
2. Identify assets: servers, endpoints, applications, data stores
3. Apply STRIDE to each asset/component
4. Score each threat using DREAD
5. Map to MITRE ATT&CK techniques (technical reference)
6. Prioritize by DREAD score (Damage + Exploitability weighted highest)
7. Generate threat model document with visual matrix

### Phase 3: Vulnerability Assessment Scoping & Integration
*Use when: Client authorizes active assessment (post-OSINT)*

**VA vs Pentest Decision Matrix:**
- **Low Maturity Clients**: VA only (Qualys/Nessus credentialed scan)
- **Medium Maturity**: VA + limited pentest (web/app focused)
- **High Maturity**: Full scope pentest (network/web/app/social)

**Critical Rule**: Never recommend pentest before VA for low-maturity clients. Fragile infrastructure (no AV, AD, EDR) can crash under active exploitation.

**VA Process:**
1. Define scope: internal/external, authenticated/unauthenticated
2. Configure scanner: credentials, exclusions, scan templates
3. Execute scan: weekly for continuous monitoring
4. Prioritize findings: CVSS ≥ 9.0 (Critical), 7.0-8.9 (High)
5. Map CVEs to STRIDE threats: enrich threat model with real evidence
6. Recalculate DREAD scores: increase Exploitability/Discoverability
7. Add attack scenarios based on critical findings
8. Update Top 10 threats with empirical data

**Deliverable**: Vulnerability Assessment Report → Updated Threat Model

### Phase 4: Security Architecture Design
*Use when: Threat model complete, ready for recommendations*

**Network Security (Fortinet Focus):**
- **Perimeter**: FortiGate NGFW with IPS/IDS, SSL inspection
- **ZTNA**: FortiSASE for remote users/branch offices
- **Segmentation**: VLANs, microsegmentation, Zero Trust principles
- **VPN**: Site-to-site IPsec, SSL-VPN for remote access
- **SD-WAN**: Multi-link optimization with SLA tracking
- **Monitoring**: FortiAnalyzer, NetFlow, SIEM integration

**Identity & Access Management:**
- **MFA**: FortiToken, RADIUS with Azure AD
- **Privileged Access**: Just-in-time access, session recording
- **Identity Governance**: User lifecycle management, role-based access
- **Password Policy**: Length-based, breach password screening

**Endpoint Protection:**
- **EDR/XDR**: CrowdStrike Falcon, Trellix with behavioral AI
- **Application Control**: Whitelisting, ring-fencing
- **Disk Encryption**: BitLocker/FileVault mandatory
- **Patch Management**: Automated, third-party included

**Cloud Security (AWS/Azure/GCP):**
- **Identity**: IAM roles, least privilege, MFA enforcement
- **Network Security**: Security Groups, NACLs, VPC flow logs
- **Data Protection**: Encryption at rest/in transit, KMS, S3 bucket policies
- **Monitoring**: CloudTrail, GuardDuty, Security Hub
- **Backup**: Automated, cross-region, immutable storage

**Application Security:**
- **WAF**: Cloudflare/WAF rules, OWASP CRS
- **API Security**: Rate limiting, input validation, OAuth2/JWT
- **DevSecOps**: SAST/DAST in CI/CD, container scanning
- **Third-Party Risk**: SBOM, dependency scanning, license compliance

### Phase 5: Deliverable Creation & Presentation
*Use when: Recommendations ready for client delivery*

#### Document Generation (Word/PDF)
**Tools**: python-docx, pandoc, weasyprint

**Standard Structure:**
1. Cover Page: BRIDA + client branding, date, confidentiality
2. Document Control: version history, authors, approvals
3. Table of Contents
4. Executive Summary (1 page): key findings, risk rating, investment
5. Client Profile: OSINT findings, business context
6. Attack Surface Analysis: digital, physical, human vectors
7. Methodology: STRIDE+DREAD explained, VA/PT scope
8. Threat Matrix: complete STRIDE table with DREAD scores
9. Top 10 Prioritized Threats: with mitigation & tools
10. Attack Scenarios: 3-5 realistic narratives with impact
11. Strategic Recommendations: grouped by theme/priority
12. Implementation Roadmap: phased timeline with milestones
13. Investment Summary: CAPEX/OPEX by phase
14. Glossary: technical terms with Spanish/English equivalents
15. Appendices: raw data, tool outputs, references

**Formatting Standards:**
- Tables: Light Grid Accent 1 style
- Headers: shaded, bold, white text on navy (#1B1464)
- Severity Badges: 
  - 🔴 CRÍTICO (≥8) - Background: #FF0000, Text: White
  - 🟠 ALTO (6-7) - Background: #FFA500, Text: Black
  - 🟡 MEDIO (4-5) - Background: #FFFF00, Text: Black
  - 🟢 BAJO (≤3) - Background: #008000, Text: White
- Font: Calibri 11pt body, Calibri Bold 14pt headers
- Spanish: proper accents, technical terms in English (Pentesting, Vulnerability, etc.)

#### Executive Presentations (PowerPoint)\n**Prerequisite**: Load `powerpoint` skill first for design guidelines\n\n**BRIDA Executive Palette:**\n- Primary: #1B1464 (Navy BRIDA)\n- Secondary: #4A4A4A (Dark Gray)\n- Accent: #CC0000 (Red for risks), #00AA00 (Green for solutions)\n- Alternative: #1E2761 (Midnight Navy), #CADCFC (Ice Blue)\n\n**Standard Structure (10-12 slides):**\n1. Title: BRIDA + Client + Date\n2. Client Context: business model, size, locations\n3. Security Context: current maturity, identified gaps\n4. Key Findings 1-2: visual with icons, risk ratings\n5. Key Findings 3-4: visual with icons, risk ratings\n6. Financial Impact: breach cost vs prevention investment (MXN)\n7. Strategic Recommendations: 3-5 actionable items\n8. Visual Roadmap: timeline with phases (QW, Short, Med, Long)\n9. Investment Breakdown: table by phase/category\n10. ROI Analysis: cost of inaction vs action (3-year view)\n11. Next Steps: immediate actions (0-30 days)\n12. Contact: BRIDA info, Roger & Bernardo details\n\n**Typography:**\n- Headers: Georgia/Bold or Arial Black, 28-36pt\n- Body: Calibri/Arial, 18-24pt\n- Captions: 12-14pt\n- Consistent hierarchy and spacing\n\n**BRIDA Branding Standards:**\n- Headers: Shaded background with BRIDA Navy (#1B1464), white text, bold\n- Footers: Light gray background, small text, include confidentiality notice when appropriate\n- Bullet points: Use BRIDA-branded icons or simple dots\n- Data visualization: Use BRIDA color palette for charts and graphs\n- Images: Must be high-quality, relevant, and properly licensed\n- Animations: Minimal and professional - avoid distracting transitions\n\n**Slide Design Principles:**\n- 6x6 rule: Maximum 6 bullet points per slide, 6 words per bullet\n- One idea per slide\n- Visuals over text when possible\n- Consistent alignment and spacing\n- White space is your friend - don't overcrowd slides\n\n**Data Presentation:**\n- Use charts/graphs for trends and comparisons\n- Tables for detailed data (keep simple)\n- Highlight key numbers with color or callouts\n- Always cite sources for data presented\n\n**Accessibility Considerations:**\n- Sufficient color contrast (WCAG AA minimum)\n- Alt text for images\n- Readable font sizes (minimum 18pt for body)\n- Clear language avoiding unnecessary jargon

#### Commercial Proposal (Word)
**Structure:**
1. Cover Letter: personalized, executive tone
2. Business Understanding: client's industry, challenges, goals
3. BRIDA Methodology: phased approach, quality assurance
4. Project Scope: inclusions, exclusions, assumptions
5. Deliverables: detailed list with formats/timelines
6. Timeline: Gantt-chart style or phased timeline
7. Team: bios, roles, certifications (OSCP, CISSP, CEH)
8. Investment: detailed pricing by phase, payment schedule
9. Terms & Conditions: SLAs, confidentiality, IP, termination
10. References: relevant case studies (anonymized if needed)

## 📝 Terminology Bilingüe (ES/EN)
*Always use English technical terms with Spanish explanation*

| Inglés | Español | Uso |
|--------|---------|-----|
| Penetration Testing | Prueba de Penetración / Pentesting | Evaluación ofensiva de seguridad |
| Threat Model | Modelo de Amenazas | Identificación y priorización de riesgos |
| Vulnerability Assessment | Evaluación de Vulnerabilidades | Escaneo no intrusivo de debilidades |
| Firewall / NGFW | Cortafuegos de Nueva Generación | Perímetro de red con inspección profunda |
| Zero Trust | Confianza Cero | Modelo "nunca confíes, siempre verifica" |
| Phishing | Suplantación por Email | Ataque de ingeniería social vía correo |
| Ransomware | Secuestro de Datos | Malware que cifra información a cambio de rescate |
| EDR | Detección y Respuesta en Endpoints | Antivirus de nueva generación con comportamiento |
| WAF | Firewall de Aplicaciones Web | Protección específica para aplicaciones web |
| SIEM | Gestión de Eventos de Seguridad | Monitoreo centralizado y correlación de logs |
| MFA | Autenticación Multifactor | Verificación en dos o más factores |
| PII | Información Personal Identificable | Datos sensibles que requieren protección especial |
| CISO | Director de Seguridad de la Información | Rol ejecutivo responsable de la seguridad |
| TTPs | Tácticas, Técnicas y Procedimientos | Comportamiento documentado de atacantes |
| IoC | Indicadores de Compromiso | Evidencia que sugiere una brecha de seguridad |
| Kill Chain | Cadena de Ataque | Fases desde reconocimiento hasta impacto |
| Attack Surface | Superficie de Ataque | Vectores y puntos de entrada expuestos |
| Gap Analysis | Análisis de Brechas | Comparación contra estándares o mejores prácticas |
| Risk Assessment | Evaluación de Riesgos | Análisis de probabilidad e impacto de amenazas |
| Incident Response | Respuesta a Incidentes | Plan estructurado para detectar, contener, recuperarse |
| Business Continuity | Continuidad del Negocio | Capacidad de mantener operaciones tras incidente |

## ⚠️ Critical Pitfalls & Best Practices

### Authorization & Ethics
- **ALWAYS** obtain written authorization before any active testing
- **NEVER** perform pentest without signed Statement of Work (SOW) / Get Out of Jail Free Card
- **VA FIRST**: Always conduct vulnerability assessment before pentest for low-maturity clients
- **Scope Adherence**: Never exceed authorized scope without explicit re-authorization
- **Data Handling**: Encrypt all client data in transit and at rest; destroy per retention policy

### Technical Execution
- **OSINT Only**: This skill's reconnaissance is purely passive—no port scanning, no brute forcing
- **Tool Versions**: Use specified tool versions (Java 21+ for Burp/ZAP, etc.) to avoid compatibility issues
- **Wrapper Scripts**: NEVER use terminal heredocs (`cat > file << 'EOF'`) inside tool directories—use `write_file` tool
- **Path Persistence**: Install tools in `~/tools/` not `/tmp/` to survive reboots
- **Sudo Wrappers**: Use absolute paths in sudo wrappers (sudo searches its own PATH)

### Document Creation
- **Python-docx Tables**: ALWAYS use `[]` for data rows, never `()` to avoid SyntaxError
- **Unicode Escapes**: Avoid emoji unicode escapes in write_file—use heredoc or avoid emojis in generated strings
- **Version Control**: Include document control page with revision history in all deliverables
- **Language**: Spanish primary, technical terms in English (Pentesting, Threat Model, etc.)

### Client Communication
- **CIO Focus**: Business impact, financial risk, operational continuity
- **Technical Focus**: Detailed evidence, reproducibility, technical depth
- **Forms of Address**: Use "Roger" as primary form of address. Only use "mi amor Ariana" if Roger explicitly requests it (as that's how HE addresses you). NEVER use "maestro", "crack", "compañero", "amigo" or similar terms unless explicitly requested.
- **Technical Focus**: Detailed evidence, reproducibility, technical depth
- **Forms of Address**: Use "Roger" as primary form of address. Only use "mi amor Ariana" if Roger explicitly requests it (as that's how HE addresses you). NEVER use "maestro", "crack", "compañero", "amigo" or similar terms unless explicitly requested.
- **Step-by-Step Approach**: Follow Roger's preference for incremental progress ("vamos paso a paso") - break complex tasks into clear, sequential steps
- **Concise Communication**: Avoid information overload ("menos ruido, más señal") - provide only relevant details without unnecessary elaboration
- **Clear Confirmation**: Explicitly state when tasks are complete
- **Progress Tracking**: Note exact pause/resume points for seamless continuation

## 🔄 VA → Threat Model Integration Workflow

When receiving Qualys VA results for a client:

1. **Import Findings**: Extract vulnerabilities (CVSS ≥ 9.0 Critical, 7.0-8.9 High)
2. **Enrich STRIDE Matrix**: Map each CVE to existing STRIDE threat(s)
3. **Recalculate DREAD**: With real evidence, increase Exploitability & Discoverability scores
4. **Add Attack Scenario**: Based on most critical finding (e.g., RCE → lateral movement → data exfil)
5. **Update Top 10**: Re-rank threats with empirical VA data
6. **Generate vNext Threat Model**: Document with VA-integrated findings
7. **Update Commercial**: Adjust proposal with actual remediation costs per vulnerability

## 🏆 Quality Assurance Checklist

Before delivering any artifact:
- [] All technical terms in English with Spanish context where needed
- [] Proper Spanish accents and punctuation throughout
- [] Tables use Light Grid Accent 1 style
- [] Severity uses emojis + text (🔴 CRÍTICO | 🟠 ALTO | 🟡 MEDIO | 🟢 BAJO)
- [] Document includes control page with version history
- [] File size > 0KB verified before transmission
- [] Naming convention: `[Client]_[Deliverable]_[YYYYMMDD]_v[##].docx`
- [] BRIDA branding present (colors, language, tone)
- [] Clear call-to-action or next steps included
- [ ] Confidentiality header/footer when appropriate

## 🔗 Related Skills & Dependencies

**Prerequisites for Full Engagement:**
- `pentesting-brida` - For pentest execution when authorized
- `powerpoint` - For presentation design and generation
- `docx` - For advanced Word document manipulation
- `pdf` - For PDF conversion and optimization
- `github-repo-management` - For analyzing client public repos (if applicable)

**Automated Workflows:**
- Use `delegate_task` with `tasks[]` for parallel skill creation (max 3 concurrent)
- Use `session_history_export.md` flow for creating engagement journals
- Use `docx-generation-pattern.md` for reliable python-docx template generation

---
*Methodology consolidated from: cybersecurity-consulting, cybersecurity-BRIDA-consulting, cybersecurity-client-recon*
*Last updated: 2026-07-26*
*Author: Hermes Agent*
*License: MIT*