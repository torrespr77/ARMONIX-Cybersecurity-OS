---
name: cybersecurity-client-recon
description: "Structured OSINT reconnaissance AND threat modeling for cybersecurity consulting engagements — from initial client research through threat model and proposal scaffolding. Covers passive OSINT, vulnerability assessment scoping, MITRE ATT&CK threat modeling, and security architecture proposals for mid-market enterprises."
triggers:
  - "investigate company security"
  - "analyze client infrastructure"
  - "OSINT recon"
  - "security assessment prep"
  - "external attack surface"
  - "familiarize with client"
  - "research target company"
  - "threat model"
  - "MITRE ATT&CK"
  - "security proposal"
  - "VA vs pentest"
  - "vulnerability assessment scoping"
  - "attack surface mapping"
---

# Cybersecurity Client Reconnaissance

## When to Use

Load this skill when the user asks to:
- Investigate a target company's external security posture
- Map the attack surface as a precursor to a security proposal
- Gather OSINT on a client before a pentest or architecture engagement
- Analyze DNS, email security (SPF/DKIM/DMARC), web tech, and org structure

This skill is **not** for active exploitation, vulnerability scanning, or anything requiring authorization. It is purely passive reconnaissance.

## Workflow

### 1. DNS Reconnaissance

```bash
# Basic DNS resolution
host <domain>
dig <domain> ANY +noall +answer
dig <domain> A +noall +answer
dig <domain> AAAA +noall +answer
dig <domain> NS +noall +answer
dig <domain> MX +noall +answer

# Email security (run ALL three):
dig <domain> TXT +noall +answer | grep -i "spf"
dig _dmarc.<domain> TXT +noall +answer
# DKIM requires knowing the selector; common selectors:
dig selector1._domainkey.<domain> CNAME +noall +answer
dig google._domainkey.<domain> TXT +noall +answer

# Subdomain discovery (passive):
# Use web_search for certificate transparency logs:
#   site:crt.sh "<domain>"
```

**What to look for:**
- ⚠️ No DMARC record = email spoofing risk
- ⚠️ No SPF record = unauthorized mail servers can spoof domain
- ⚠️ Missing DKIM = no email integrity verification
- CDN identification (Cloudflare, Akamai, etc. via IP/NS analysis)
- Hosting provider identification

### 2. Web Technology Discovery

Search for:
- Tech stack (CMS framework, hosting provider, CDN)
- Public-facing web apps and portals
- Security headers (HTTPS, HSTS, CSP clues from HTTP responses)
- E-commerce platforms (may indicate PCI-DSS scope)

### 3. Organizational OSINT

Search for:
- Corporate leadership (CEO, CIO, CISO) on LinkedIn
- Company size, locations, business model
- Recent news (breaches, expansions, M&A)
- Franchise/store count (impacts network architecture scope)
- Technologies mentioned in job postings (indicates infrastructure stack)

### 4. Threat Landscape Modeling

Based on gathered data, model:
- **Attack surface**: web apps, email, remote access, cloud services, distributed locations
- **Key risks**: BYOD, franchise model, e-commerce, payment processing
- **Compliance requirements**: PCI-DSS (if payments), local data protection laws
- **Likely gaps**: No CISO = governance gap, distributed locations = segmentation complexity

### 5. Output Format

Present findings as:
1. **Corporate Profile** table (name, industry, size, locations)
2. **Infrastructure** table (domain, hosting, CDN, email, platforms)
3. **DNS/Email Security** summary (SPF/DKIM/DMARC status)
4. **Key Personnel** found (execs, IT leadership)
5. **Identified Cybersecurity Challenges** (bullet list, prioritized)
6. **Recommendations for Next Steps** (what to probe deeper)

## Generating Deliverables

### Threat Model Document (.docx)
Use `python-docx` to generate a Word document. The `cybersecurity-BRIDA-consulting` skill has the full template specification. Key structure:
- Portada → Índice → Resumen Ejecutivo → OSINT → Superficie de Ataque → Matriz STRIDE+DREAD → Top 10 → Escenarios → Recomendaciones → Hoja de Ruta → Glosario → Control de Versiones
- Use `Light Grid Accent 1` table style
- Color-code DREAD scores: red (≥8), orange (≥6)
- Severity emojis: 🔴 CRITICAL | 🟠 HIGH | 🟡 MEDIUM | 🟢 LOW

### CIO Presentation (.pptx)
**Load the `powerpoint` skill before generating.** It contains design guidelines, color palettes, layout options, and QA procedures.
For BRIDA cybersecurity proposals, use the **Midnight Executive** palette (navy `1E2761` + ice blue `CADCFC` + white) or BRIDA's own navy (`1B1464`).
Structure: Title → Context → Findings → Financial Risk → Recommendations → Roadmap → Investment → ROI → Next Steps → Contact.

## Preferencias del Usuario (confirmadas sesión 2026-06-14)
- **Idioma:** Español primario, términos técnicos en inglés (Pentesting, Threat Model, Vulnerability, etc.)
- **Formato entregables:** Word (.docx) como primario, PDF como secundario. Generar con python-docx.
- **Tablas:** Estilo `Light Grid Accent 1` en Word
- **Severidad:** Emojis 🔴🟠🟡🟢 + texto (CRÍTICO/ALTO/MEDIO/BAJO)
- **Metodología Threat Model:** STRIDE+DREAD principal, MITRE ATT&CK en anexos (confirmado por Roger)
- **VA siempre antes de Pentest** en clientes de madurez baja
- **Usuario:** Roger (nickname), consultor cybersecurity BRIDA IT Services

## Pitfalls

- **Don't actively scan ports or run Nmap** without explicit authorization. This skill is passive-only.
- **Don't confuse USA and Mexico entities** with similar names (e.g., Pollo Pepe USA vs MX). Check domains carefully.
- **DKIM selectors** vary by provider. Google Workspace uses `google`, others use `selector1`, `selector2`, `k1`, etc. If none found, note it as "not publicly verifiable."
- **WordPress detection**: check for `/wp-admin/`, `/wp-content/`, or generator meta tags.
- **Franchise models** mean decentralized IT — this is always a segmentation/SASE use case.
- **No generar presentaciones PowerPoint sin cargar el skill `powerpoint` primero.** Contiene guías de diseño, paletas de color y QA.

## Support Files

- `references/grupo-pepe-osint.md` — Enriched OSINT + Threat Model summary for Grupo Pepe (Pollo Pepe, Pipinos Pizza, El Pollo Bronco, Barbacos). Includes engagement status, known gaps, and top 5 threats.
- `references/threat-modeling-methodology.md` — Threat modeling framework selection (MITRE ATT&CK vs STRIDE), VA vs Pentest decision matrix, ATT&CK heat map methodology, and proposal deliverable structure.

## Engagement Lifecycle

A full cybersecurity consulting engagement typically follows this flow:

1. **Passive OSINT / Recon** (this skill's core) — What can we see without touching their infrastructure?
2. **Vulnerability Assessment** (passive/active with authorization) — Scan for known CVEs, misconfigurations
3. **Threat Modeling** (see `references/threat-modeling-methodology.md`) — Map adversary TTPs to the client's infrastructure
4. **Scoped Penetration Test** (only after VA, with explicit authorization) — Validate exploitability
5. **Proposal Writing** — Architecture recommendations, tool mapping, phased roadmap
6. **Implementation Support** — Assist with deployment of recommended controls

⚠️ **Rule: Never recommend a Pentest before a VA when maturity is low.** A fragile infrastructure (no AV, no AD, no EDR) can crash under active exploitation. Always scope appropriately.

## Integración de Resultados VA → Threat Model (Flujo de Trabajo)

Cuando se reciban resultados de Qualys VA para un cliente:

1. **Importar hallazgos** — Extraer vulnerabilidades críticas (CVSS ≥ 9.0) y altas (CVSS 7.0-8.9)
2. **Enriquecer la Matriz STRIDE** — Mapear cada CVE a una amenaza STRIDE existente
3. **Recalcular DREAD** — Con evidencia real, los scores de Exploitability y Discoverability suben
4. **Agregar escenario de ataque** — Basado en la vulnerabilidad más crítica encontrada
5. **Actualizar Top 10** — Reordenar con evidencia empírica del VA
6. **Generar Threat Model vNext** — Documento actualizado con hallazgos VA integrados
7. **Comercial** — Actualizar propuesta con costo real de remediación por vulnerabilidad
