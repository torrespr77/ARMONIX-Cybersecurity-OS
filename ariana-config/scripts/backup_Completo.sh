#!/usr/bin/env bash
# ----------------------------------------------------------------------
# Backup completo de Hermes Agent + entorno de pentesting
# ----------------------------------------------------------------------
set -euo pipefail

# ---------- CONFIG ----------
BACKUP_DIR="$HOME/.hermes/backups"
LOG_FILE="$HOME/.hermes/backup.log"
LOCK_FILE="/tmp/hermes_backup.lock"
RETENTION=3
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/hermes_backup_${TIMESTAMP}.tar.gz"
# ----------------------------

# --- Lock para evitar ejecuciones simultáneas ---
if [[ -e "$LOCK_FILE" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') │ Backup ya en curso → saliendo" >> "$LOG_FILE"
    exit 0
fi
touch "$LOCK_FILE"
# ------------------------------------------------

# Directorio donde vivirá todo lo que vamos a empaquetar
WORKDIR="$HOME"
# Creamos un archivo de lista temporal (más legible que una larga cadena)
TMP_LIST=$(mktemp)

# ---- Definir qué queremos incluir ----
# (se omite cualquier ruta que no exista)
declare -a INCLUDE=(
    "$WORKDIR/.hermes/config.yaml"
    "$WORKDIR/.hermes/state.db"
    "$WORKDIR/.hermes/skills"
    "$WORKDIR/.hermes/plugins"
    "$WORKDIR/.hermes/cron"
    "$WORKDIR/.hermes/memories"
    "$WORKDIR/.hermes/profiles"
    "$WORKDIR/.hermes/sessions"
    "$WORKDIR/.hermes/logs"
    "$WORKDIR/scripts"
    "$WORKDIR/tools"
    "$WORKDIR/.local/bin"
    "$WORKDIR/go/bin"
    "$WORKDIR/.cargo/bin"
    "$WORKDIR/.bashrc"
    "$WORKDIR/.zshrc"
    "$WORKDIR/.profile"
    "$WORKDIR/.bash_profile"
    "$WORKDIR/.zprofile"
    "$WORKDIR/.ssh"
)

# Construir la lista de rutas existentes
for p in "${INCLUDE[@]}"; do
    if [[ -e "$p" || -L "$p" ]]; then
        # `tar` necesita rutas absolutas cuando se usa -P o cuando se especifica -C
        # Aquí usamos rutas absolutas y luego -P para que las guarde tal cual.
        echo "$p" >> "$TMP_LIST"
    fi
done

# Si nada fue encontrado, salir con error
if [[ ! -s "$TMP_LIST" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') │ ERROR: No se encontró nada para respaldar" >> "$LOG_FILE"
    rm -f "$LOCK_FILE" "$TMP_LIST"
    exit 1
fi

# --- Ejecutar el backup ---
# nice/ionice para reducir impacto, pigz para compresión paralela (si está disponible)
# Si no tienes pigz, caerá a gzip automáticamente.
# Capturamos cualquier error de la tubería
{
    tar -czf - -P -T "$TMP_LIST" |
    (command -v pigz >/dev/null && pigz || gzip) > "$BACKUP_FILE"
} 2>>"$LOG_FILE"

RESULT=$?
# ---------------------------------

# Limpiar temporal
rm -f "$TMP_LIST"

if [[ $RESULT -eq 0 && -s "$BACKUP_FILE" ]]; then
    SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "$(date '+%Y-%m-%d %H:%M:%S') │ OK │ $SIZE │ $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') │ ERROR │ tar/gzip falló o archivo vacío (código $RESULT)" >> "$LOG_FILE"
    # Eliminar archivo potencialmente corrupto
    rm -f "$BACKUP_FILE"
    exit 1
fi

# --- Retención: eliminar los backups más antiguos si超出 RETENTION ---
cd "$BACKUP_DIR"
ls -t hermes_backup_*.tar.gz | tail -n +$((RETENTION+1)) | xargs -r rm -f --
# --------------------------------------------------------------------

# Liberar lock
rm -f "$LOCK_FILE"

exit $RESULT