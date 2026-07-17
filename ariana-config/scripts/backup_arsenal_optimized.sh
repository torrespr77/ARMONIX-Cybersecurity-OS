#!/bin/bash
# Optimized backup - excludes redundant/large dirs, uses pigz for parallel compression
set -e

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.hermes/backups"
BACKUP_FILE="${BACKUP_DIR}/hermes_backup_${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR"

# Use pigz (parallel gzip) if available, else gzip
if command -v pigz >/dev/null 2>&1; then
    COMPRESS="pigz"
else
    COMPRESS="gzip"
fi

# Create compressed tar archive with exclusions
tar --exclude="$HOME/tools/backups" \
    --exclude="$HOME/tools/cloud/prowler" \
    --exclude="$HOME/tools/cloud/ScoutSuite" \
    --exclude="$HOME/tools/metasploit-framework" \
    --exclude="$HOME/tools/venv2" \
    -c "$HOME/.hermes/state.db" "$HOME/.hermes/skills" "$HOME/tools" | $COMPRESS > "$BACKUP_FILE"

echo "Backup created: $BACKUP_FILE"
ls -lh "$BACKUP_FILE"
