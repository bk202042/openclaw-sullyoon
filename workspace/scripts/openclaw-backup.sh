#!/usr/bin/env bash
# =============================================================================
# openclaw-backup.sh
# Time Machine-style snapshot of ~/.openclaw → Google Drive
#
# Usage:
#   ./openclaw-backup.sh              # full backup
#   ./openclaw-backup.sh --dry-run    # simulate only (no upload)
#   ./openclaw-backup.sh --no-upload  # create archive but skip upload
# =============================================================================

set -euo pipefail

# --- Config ------------------------------------------------------------------
OPENCLAW_DIR="$HOME/.openclaw"
BACKUP_STAGING="/tmp/openclaw-backups"
TIMESTAMP=$(date +"%Y-%m-%dT%H%M")
DATEMONTH=$(date +"%Y-%m")
ARCHIVE_NAME="openclaw-backup-${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${BACKUP_STAGING}/${ARCHIVE_NAME}"
CHECKSUM_PATH="${ARCHIVE_PATH}.sha256"
DRIVE_PARENT_FOLDER="OpenClaw-Backups"        # root folder name on Drive
DRIVE_MONTH_FOLDER="${DRIVE_PARENT_FOLDER}/${DATEMONTH}"
RETENTION_DAYS=30                              # delete Drive backups older than N days
LOG_FILE="${BACKUP_STAGING}/backup.log"
DRY_RUN=false
SKIP_UPLOAD=false

# --- Parse args --------------------------------------------------------------
for arg in "$@"; do
  case $arg in
    --dry-run)    DRY_RUN=true ;;
    --no-upload)  SKIP_UPLOAD=true ;;
  esac
done

# --- Helpers -----------------------------------------------------------------
log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE"; }
die() { log "❌ ERROR: $*"; exit 1; }

# --- Preflight ---------------------------------------------------------------
mkdir -p "$BACKUP_STAGING"
log "🔵 OpenClaw Backup — ${TIMESTAMP}"
log "Source : ${OPENCLAW_DIR}"
log "Archive: ${ARCHIVE_PATH}"
[[ "$DRY_RUN" == true ]] && log "⚠️  DRY RUN MODE — no files will be written"

# Check gog CLI available (used for Drive upload)
if [[ "$SKIP_UPLOAD" == false && "$DRY_RUN" == false ]]; then
  command -v gog >/dev/null 2>&1 || die "gog CLI not found. Install or set --no-upload."
fi

# --- Exclusion list ----------------------------------------------------------
# These paths are relative to OPENCLAW_DIR
EXCLUDES=(
  ".git"
  "logs"
  "subagents"
  "tmp"
  "telegram"
  ".env"
  ".DS_Store"
  "*.log"
  "*.jsonl"
  "exec-approvals.json"
  "update-check.json"
  "workspace/config/excalidraw.log"
  # Re-installable skill deps (symlinks tracked in git)
  "skills/*/node_modules"
)

# Build --exclude flags for tar
EXCLUDE_FLAGS=()
for ex in "${EXCLUDES[@]}"; do
  EXCLUDE_FLAGS+=("--exclude=${ex}")
done

# --- Create archive ----------------------------------------------------------
log "📦 Creating archive..."

if [[ "$DRY_RUN" == true ]]; then
  log "   [DRY RUN] Would run: tar -czf ${ARCHIVE_PATH} ${EXCLUDE_FLAGS[*]} -C $HOME .openclaw"
else
  tar -czf "$ARCHIVE_PATH" \
    "${EXCLUDE_FLAGS[@]}" \
    -C "$HOME" \
    ".openclaw" 2>/dev/null || true

  ARCHIVE_SIZE=$(du -sh "$ARCHIVE_PATH" | cut -f1)
  log "✅ Archive created: ${ARCHIVE_SIZE}"

  # Checksum
  shasum -a 256 "$ARCHIVE_PATH" > "$CHECKSUM_PATH"
  log "✅ SHA256: $(cat "$CHECKSUM_PATH" | awk '{print $1}')"
fi

# --- Upload to Google Drive --------------------------------------------------
if [[ "$SKIP_UPLOAD" == true ]]; then
  log "⏭️  Skipping upload (--no-upload)"
  log "   Archive saved at: ${ARCHIVE_PATH}"
  exit 0
fi

if [[ "$DRY_RUN" == true ]]; then
  log "   [DRY RUN] Would upload to Drive: ${DRIVE_MONTH_FOLDER}/${ARCHIVE_NAME}"
  log "   [DRY RUN] Would upload checksum: ${DRIVE_MONTH_FOLDER}/${ARCHIVE_NAME}.sha256"
  exit 0
fi

log "☁️  Uploading to Google Drive: ${DRIVE_MONTH_FOLDER}/..."

# Ensure parent folder exists and get/create month subfolder
PARENT_ID=$(gog drive mkdir --parents "${DRIVE_PARENT_FOLDER}" 2>/dev/null | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4 || true)

if [[ -z "$PARENT_ID" ]]; then
  # Try list approach
  PARENT_ID=$(gog drive ls --name "${DRIVE_PARENT_FOLDER}" --json 2>/dev/null | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0]['id'])" 2>/dev/null || true)
fi

# Upload archive
FILE_ID=$(gog drive upload \
  --file "$ARCHIVE_PATH" \
  --name "$ARCHIVE_NAME" \
  --folder "${DRIVE_MONTH_FOLDER}" \
  --parents \
  2>/dev/null | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4 || true)

# Upload checksum
gog drive upload \
  --file "$CHECKSUM_PATH" \
  --name "${ARCHIVE_NAME}.sha256" \
  --folder "${DRIVE_MONTH_FOLDER}" \
  --parents \
  2>/dev/null || true

log "✅ Upload complete. File ID: ${FILE_ID:-unknown}"

# --- Retention: delete old backups -------------------------------------------
log "🗑️  Applying retention policy (>${RETENTION_DAYS} days)..."
CUTOFF=$(date -v-${RETENTION_DAYS}d +"%Y-%m-%dT%H:%M:%S" 2>/dev/null || date -d "-${RETENTION_DAYS} days" +"%Y-%m-%dT%H:%M:%S")

OLD_FILES=$(gog drive ls \
  --folder "${DRIVE_PARENT_FOLDER}" \
  --recursive \
  --json \
  2>/dev/null | python3 -c "
import json, sys
from datetime import datetime
cutoff = '${CUTOFF}'
files = json.load(sys.stdin)
for f in files:
    created = f.get('createdTime','')[:19]
    if created and created < cutoff and f.get('name','').startswith('openclaw-backup-'):
        print(f['id'] + ' ' + f['name'])
" 2>/dev/null || true)

if [[ -n "$OLD_FILES" ]]; then
  while IFS= read -r line; do
    FILE_ID_OLD=$(echo "$line" | awk '{print $1}')
    FILE_NAME_OLD=$(echo "$line" | awk '{print $2}')
    log "   Deleting old backup: ${FILE_NAME_OLD}"
    gog drive delete --id "$FILE_ID_OLD" 2>/dev/null || true
  done <<< "$OLD_FILES"
else
  log "   No old backups to delete."
fi

# --- Local cleanup -----------------------------------------------------------
# Keep only last 3 local archives (staging is temp)
find "$BACKUP_STAGING" -name "openclaw-backup-*.tar.gz" | sort | head -n -3 | xargs rm -f 2>/dev/null || true

# --- Done --------------------------------------------------------------------
log "🎉 Backup complete: ${ARCHIVE_NAME}"
log "   Drive path: ${DRIVE_MONTH_FOLDER}/${ARCHIVE_NAME}"
log ""

# Telegram notification (optional — uses openclaw message routing)
if command -v openclaw >/dev/null 2>&1; then
  openclaw notify --message "✅ OpenClaw 백업 완료
📦 ${ARCHIVE_NAME}
📁 Drive: ${DRIVE_MONTH_FOLDER}
🕐 ${TIMESTAMP}" 2>/dev/null || true
fi
