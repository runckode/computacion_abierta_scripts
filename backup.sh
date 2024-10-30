#!/bin/bash

SOURCE_DIR="${HOME}/data"
BACKUP_DIR="${HOME}/scripts/backups"
LOG_FILE="${HOME}/scripts/registro_respaldo.log"

mkdir -p "$SOURCE_DIR" "$BACKUP_DIR"
touch "$LOG_FILE"

if [ ! -w "$BACKUP_DIR" ] || [ ! -w "$LOG_FILE" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: Insufficient permissions for backup directory or log file." | tee -a "$LOG_FILE"
  exit 1
fi

REQUIRED_SPACE_MB=100
AVAILABLE_SPACE_MB=$(df --output=avail "$BACKUP_DIR" | tail -n 1 | awk '{print $1}')
AVAILABLE_SPACE_MB=$((AVAILABLE_SPACE_MB / 1024))

if [ "$AVAILABLE_SPACE_MB" -lt "$REQUIRED_SPACE_MB" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: Not enough disk space. Required: ${REQUIRED_SPACE_MB}MB, Available: ${AVAILABLE_SPACE_MB}MB." | tee -a "$LOG_FILE"
  exit 1
fi

BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y-%m-%d).tar.gz"

if [ -f "$BACKUP_FILE" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: Backup file $BACKUP_FILE already exists." | tee -a "$LOG_FILE"
  exit 1
fi

if tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" . 2>>"$LOG_FILE"; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: Backup successfully created at $BACKUP_FILE" | tee -a "$LOG_FILE"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: Backup creation failed." | tee -a "$LOG_FILE"
  exit 1
fi
