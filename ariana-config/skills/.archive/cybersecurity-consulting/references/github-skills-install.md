# Instalación de Skills desde Repositorios GitHub

## Proceso para instalar skills de repositorios públicos

### Paso 1: Clonar el repositorio temporalmente
```bash
git clone https://github.com/<usuario>/<repo>.git /tmp/github-skills-source
```

### Paso 2: Revisar la estructura del repo
```bash
ls -la /tmp/github-skills-source/
```

### Paso 3: Crear directorio del skill en Hermes
```bash
mkdir -p ~/.hermes/skills/<nombre-skill>
```

### Paso 4: Adaptar al formato Hermes SKILL.md
Cada skill necesita YAML frontmatter + markdown body:
```yaml
---
name: nombre-del-skill
description: Descripción corta de qué hace y cuándo se activa.
---

# Título del Skill
Contenido en markdown con instrucciones, pitfalls y ejemplos.
```

### Paso 5: Adaptar al contexto BRIDA
- Adaptar ejemplos al stack BRIDA (Fortinet, Qualys, CrowdStrike, etc.)
- Agregar mapeo a clientes típicos (Grupo Pepe, Farmacias Guadalajara)
- Incluir terminología bilingüe (EN→ES)
- Agregar referencias a frameworks (MITRE ATT&CK, NIST CSF, D3FEND)

### Repositorios conocidos con skills de cybersecurity
- **mukul975/Anthropic-Cybersecurity-Skills** — 14+ skills
  - Ya instalados/adaptados para BRIDA (Jun 2026): vulnerability-management-brida, penetration-testing-brida, incident-response-brida, network-security-brida, phishing-defense-brida, ransomware-defense-brida, zero-trust-brida, web-application-security-brida, security-operations-brida, ot-ics-security-brida, red-teaming-brida, endpoint-security-brida, mobile-security-brida, compliance-governance-brida
