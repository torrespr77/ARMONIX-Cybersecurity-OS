#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# sync-to-github.sh
# Sincroniza TODA la configuración de Ariana (Hermes Agent) al
# repo privado torrespr77/Cybersecurity en GitHub.
#
# Ejecutado semanalmente por el Weekly Health Check (viernes 10AM)
# Autor: Ariana (Hermes Agent) para Roger Torres
# ═══════════════════════════════════════════════════════════════

set -euo pipefail

# ── Configuración ──────────────────────────────────────────────
REPO_DIR="$HOME/brida-security-project"
HERMES_DIR="$HOME/.hermes"
SCRIPTS_DIR="$HOME/scripts"
STAGING_DIR=$(mktemp -d)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
DATE_SHORT=$(date '+%Y-%m-%d')

# Colores/badges
OK="✅"
WARN="⚠️"
ERR="❌"

# Cleanup al salir
cleanup() {
    rm -rf "$STAGING_DIR"
}
trap cleanup EXIT

# ── Funciones ──────────────────────────────────────────────────

log() {
    echo "[$(date '+%H:%M:%S')] $*" >&2
}

# Sanitiza config.yaml: reemplaza valores de API keys, tokens, passwords
sanitize_config() {
    local input="$1"
    local output="$2"
    
    cp "$input" "$output"
    
    # Reemplazar líneas con api_key, token, password, secret con ***REDACTED***
    sed -i -E 's/(api_key[[:space:]]*:[[:space:]]*).+/\1***REDACTED***/g' "$output"
    sed -i -E 's/(api[-_]?key[[:space:]]*:[[:space:]]*).+/\1***REDACTED***/g' "$output"
    sed -i -E 's/(token[[:space:]]*:[[:space:]]*).+/\1***REDACTED***/g' "$output"
    sed -i -E 's/(password[[:space:]]*:[[:space:]]*).+/\1***REDACTED***/g' "$output"
    sed -i -E 's/(secret[[:space:]]*:[[:space:]]*).+/\1***REDACTED***/g' "$output"
    
    # Reemplazar valores después de API_KEY=, TOKEN=, etc.
    sed -i -E 's/(API_KEY[[:space:]]*[:=][[:space:]]*).+/\1***REDACTED***/g' "$output"
    sed -i -E 's/(TOKEN[[:space:]]*[:=][[:space:]]*).+/\1***REDACTED***/g' "$output"
    sed -i -E 's/(SECRET[[:space:]]*[:=][[:space:]]*).+/\1***REDACTED***/g' "$output"
    sed -i -E 's/(PASSWORD[[:space:]]*[:=][[:space:]]*).+/\1***REDACTED***/g' "$output"
    
    # Eliminar tokens conocidos (sk-, pk-, AKIA, ghp_, etc.)
    sed -i -E 's/(sk-[A-Za-z0-9]{20,})/***REDACTED***/g' "$output"
    sed -i -E 's/(pk-[A-Za-z0-9]{20,})/***REDACTED***/g' "$output"
    sed -i -E 's/(AKIA[A-Z0-9]{16})/***REDACTED***/g' "$output"
    sed -i -E 's/(gh[pousr]_[A-Za-z0-9]{36})/***REDACTED***/g' "$output"
    sed -i -E 's/([0-9]{8,10}:[A-Za-z0-9_-]{30,})/***REDACTED***/g' "$output"
}

# ── Verificaciones previas ─────────────────────────────────────
log "Iniciando sync de Ariana → GitHub"

if [ ! -d "$REPO_DIR" ]; then
    echo "${ERR} Repo local no encontrado: $REPO_DIR"
    echo "   Clonar primero: git clone git@github.com:torrespr77/Cybersecurity.git ~/brida-security-project"
    exit 1
fi

if [ ! -d "$HERMES_DIR" ]; then
    echo "${ERR} Directorio Hermes no encontrado: $HERMES_DIR"
    exit 1
fi

# ── 1. Preparar estructura de staging ──────────────────────────
log "Preparando staging en $STAGING_DIR"

mkdir -p "$STAGING_DIR/ariana-config/skills"
mkdir -p "$STAGING_DIR/ariana-config/scripts"

# ── 2. Copiar identidad (SOUL.md) ──────────────────────────────
log "Copiando SOUL.md"
cp "$HERMES_DIR/SOUL.md" "$STAGING_DIR/ariana-config/SOUL.md" 2>/dev/null || echo "${WARN} SOUL.md no encontrado"

# ── 3. Copiar memoria persistente ──────────────────────────────
log "Copiando archivos de memoria"

# Memory store (system prompt copy)
cp "$HERMES_DIR/MEMORY.md" "$STAGING_DIR/ariana-config/MEMORY.md" 2>/dev/null || echo "${WARN} MEMORY.md no encontrado"

# Persistent memory (the actual store)
cp "$HERMES_DIR/memories/MEMORY.md" "$STAGING_DIR/ariana-config/memories-MEMORY.md" 2>/dev/null || echo "${WARN} memories/MEMORY.md no encontrado"
cp "$HERMES_DIR/memories/USER.md" "$STAGING_DIR/ariana-config/memories-USER.md" 2>/dev/null || echo "${WARN} memories/USER.md no encontrado"

# User profile
cp "$HERMES_DIR/USER.md" "$STAGING_DIR/ariana-config/USER.md" 2>/dev/null || echo "${WARN} USER.md no encontrado"

# ── 4. Copiar config.yaml sanitizada ───────────────────────────
log "Copiando y sanitizando config.yaml"
sanitize_config "$HERMES_DIR/config.yaml" "$STAGING_DIR/ariana-config/config.yaml.sanitized"

# ── 5. Copiar cron jobs ────────────────────────────────────────
log "Copiando cron jobs"
cp "$HERMES_DIR/cron/jobs.json" "$STAGING_DIR/ariana-config/cron-jobs.json" 2>/dev/null || echo "${WARN} cron/jobs.json no encontrado"

# ── 6. Copiar skills (activas + .archive) ──────────────────────
log "Copiando skills (activas + .archive)"

SKILL_COUNT=$(find "$HERMES_DIR/skills" -name "SKILL.md" 2>/dev/null | wc -l)
ACTIVE_COUNT=$(find "$HERMES_DIR/skills" -name "SKILL.md" -not -path "*/.archive/*" 2>/dev/null | wc -l)
ARCHIVE_COUNT=$(find "$HERMES_DIR/skills/.archive" -name "SKILL.md" 2>/dev/null | wc -l)

# Copiar todo el árbol de skills (incluye .archive)
rsync -a --delete \
    --exclude='__pycache__/' \
    --exclude='*.pyc' \
    --exclude='.venv/' \
    --exclude='venv/' \
    --exclude='node_modules/' \
    "$HERMES_DIR/skills/" "$STAGING_DIR/ariana-config/skills/"

log "Skills: $ACTIVE_COUNT activas, $ARCHIVE_COUNT archivadas, $SKILL_COUNT total"

# ── 7. Copiar scripts operacionales ────────────────────────────
log "Copiando scripts"

if [ -d "$SCRIPTS_DIR" ]; then
    cp "$SCRIPTS_DIR"/*.py "$SCRIPTS_DIR"/*.sh "$STAGING_DIR/ariana-config/scripts/" 2>/dev/null || true
fi

SCRIPT_COUNT=$(find "$STAGING_DIR/ariana-config/scripts" -type f 2>/dev/null | wc -l)
log "Scripts: $SCRIPT_COUNT archivos"

# ── 8. Generar README ──────────────────────────────────────────
log "Generando README"

MEMORY_CHARS=$(wc -c < "$HERMES_DIR/memories/MEMORY.md" 2>/dev/null || echo "N/A")
USER_CHARS=$(wc -c < "$HERMES_DIR/memories/USER.md" 2>/dev/null || echo "N/A")

cat > "$STAGING_DIR/ariana-config/README.md" << EOF
# 🤖 Ariana Agent — Configuration Backup

This directory contains the full configuration backup of **Ariana**, 
a Hermes Agent instance for cybersecurity consulting at BRIDA IT Services.

## Contents

| Directory/File | Description |
|---|---|
| \`SOUL.md\` | Agent personality and identity |
| \`MEMORY.md\` | System prompt memory copy |
| \`memories-MEMORY.md\` | Persistent memory store (memory) |
| \`memories-USER.md\` | Persistent memory store (user profile) |
| \`USER.md\` | User profile copy |
| \`config.yaml.sanitized\` | Hermes config with secrets redacted |
| \`cron-jobs.json\` | Scheduled cron job definitions |
| \`skills/\` | All skills (active + archived) |
| \`scripts/\` | Operational scripts |

## Stats

- **Skills**: $SKILL_COUNT total ($ACTIVE_COUNT active, $ARCHIVE_COUNT archived)
- **Memory store**: $MEMORY_CHARS chars
- **User store**: $USER_CHARS chars
- **Scripts**: $SCRIPT_COUNT files
- **Generated**: $TIMESTAMP

## Restore Instructions

To restore Ariana on a new Hermes Agent instance:

\`\`\`bash
# 1. Copy identity
cp ariana-config/SOUL.md ~/.hermes/
cp ariana-config/USER.md ~/.hermes/

# 2. Copy persistent memory
cp ariana-config/memories-MEMORY.md ~/.hermes/memories/MEMORY.md
cp ariana-config/memories-USER.md ~/.hermes/memories/USER.md

# 3. Copy skills
rsync -av ariana-config/skills/ ~/.hermes/skills/

# 4. Copy scripts
cp ariana-config/scripts/* ~/scripts/

# 5. Review config.yaml.sanitized and fill in secrets
#    DO NOT copy blindly — you need to set your actual API keys, tokens, etc.
cp ariana-config/config.yaml.sanitized ~/.hermes/config.yaml
# Edit and fill in: Telegram bot token, Tavily API key, provider keys, etc.

# 6. Import cron jobs
# Review ariana-config/cron-jobs.json and recreate via: hermes cron create ...

# 7. Restart gateway
hermes gateway restart
\`\`\`

## Security

- All secrets (API keys, tokens, passwords) are redacted as \`***REDACTED***\`
- The \`.env\` file is NEVER included — it contains live credentials
- \`auth.json\` is NEVER included — it contains provider authentication
- \`state.db\` is NEVER included — it contains conversation history
- This repo MUST remain **private**

## Schedule

This backup runs automatically every Friday at 10:00 AM (America/Mexico_City)
as part of the Hermes Weekly Health Check.

---
Author: Ariana (Hermes Agent) for Ing. Rogelio Torres Pimentel
Last sync: $TIMESTAMP
EOF

# ── 9. Sincronizar staging → repo ──────────────────────────────
log "Sincronizando al repo local"

cd "$REPO_DIR"

# Asegurar que el repo está limpio de cambios locales previos
# (solo para el directorio ariana-config, no toca otros archivos)
git fetch origin 2>/dev/null || true

# Copiar staging al repo (rsync delete para mantener mirror exacto)
rsync -a --delete \
    --exclude='.git/' \
    "$STAGING_DIR/ariana-config/" "$REPO_DIR/ariana-config/"

# ── 10. Git commit estructurado ────────────────────────────────
log "Creando commit"

git add ariana-config/
git add .gitignore 2>/dev/null || true

# Verificar si hay cambios para commitear
if git diff --cached --quiet; then
    log "No hay cambios desde el último sync"
    echo "${OK} No hay cambios para sincronizar — todo al día"
    exit 0
fi

# Contar archivos cambiados
CHANGED_FILES=$(git diff --cached --name-only | wc -l)

git commit -m "backup: ariana-config weekly sync

- Skills: $ACTIVE_COUNT active, $ARCHIVE_COUNT archived ($SKILL_COUNT total)
- Memory store: $MEMORY_CHARS chars
- User store: $USER_CHARS chars
- Scripts: $SCRIPT_COUNT files
- Config: sanitized (secrets redacted)
- Changed files: $CHANGED_FILES
- Generated: $TIMESTAMP"

COMMIT_HASH=$(git rev-parse --short HEAD)

# ── 11. Push ───────────────────────────────────────────────────
log "Pushing a GitHub"

if git push origin main 2>&1; then
    echo "${OK} Sync completado exitosamente"
    echo "   Commit: $COMMIT_HASH"
    echo "   Skills: $SKILL_COUNT ($ACTIVE_COUNT active + $ARCHIVE_COUNT archived)"
    echo "   Scripts: $SCRIPT_COUNT"
    echo "   Changed files: $CHANGED_FILES"
    echo "   Timestamp: $TIMESTAMP"
    exit 0
else
    echo "${ERR} Push falló — revisar conectividad o credenciales SSH"
    echo "   Commit local: $COMMIT_HASH (no pushed)"
    exit 1
fi
