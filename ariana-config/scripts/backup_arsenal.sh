#!/bin/bash
# Backup Hermes state.db, skills, and tools arsenal
set -e

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.hermes/backups"
BACKUP_FILE="${BACKUP_DIR}/hermes_backup_${TIMESTAMP}.tar.gz"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Create compressed tar archive
tar -czf "$BACKUP_FILE" "$HOME/.hermes/state.db" "$HOME/.hermes/skills" "$HOME/tools"

# Optional: keep only last 7 backups (optional)
# cd "$BACKUP_DIR" && ls -t hermes_backup_*.tar.gz | tail -n +8 | xargs -r rm --

echo "Backup created: $BACKUP_FILE"