#!/bin/bash

set -Eeuo pipefail

###############################################
# DNCloud Backup Script
###############################################

# Must run as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo:"
    echo "sudo ./backup.sh"
    exit 1
fi

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_ROOT="/data/backups/daily"
BACKUP_DIR="${BACKUP_ROOT}/${DATE}"
ARCHIVE="${BACKUP_ROOT}/${DATE}.tar.gz"

cleanup() {
    rm -rf "$BACKUP_DIR"
}

trap cleanup EXIT

echo
echo "==========================================="
echo " DNCloud Backup"
echo "==========================================="
echo "Backup Time : $DATE"
echo

# Check rsync
if ! command -v rsync >/dev/null 2>&1; then
    echo "ERROR: rsync is not installed."
    echo
    echo "Install using:"
    echo "apt install rsync"
    exit 1
fi

mkdir -p "$BACKUP_DIR"

###############################################
# Backup Docker Config
###############################################

echo "Backing up /opt/stacks..."

rsync -aHAX \
    --delete \
    /opt/stacks/ \
    "$BACKUP_DIR/stacks/"

###############################################
# Backup Application Data
###############################################

echo
echo "Backing up /data/appdata..."

rsync -aHAX \
    --exclude="*/cache/" \
    --exclude="*/Cache/" \
    --exclude="*/logs/" \
    --exclude="*/log/" \
    --exclude="*/tmp/" \
    --exclude="*/temp/" \
    /data/appdata/ \
    "$BACKUP_DIR/appdata/"

###############################################
# Compress
###############################################

echo
echo "Compressing backup..."

cd "$BACKUP_ROOT"

tar -czf "${DATE}.tar.gz" "$DATE"

###############################################
# Cleanup old backups
###############################################

echo
echo "Removing backups older than 7 days..."

find "$BACKUP_ROOT" \
    -type f \
    -name "*.tar.gz" \
    -mtime +7 \
    -print \
    -delete

###############################################
# Summary
###############################################

echo
echo "==========================================="
echo " Backup Completed Successfully"
echo "==========================================="

echo
echo "Archive:"
echo "$ARCHIVE"

echo
ls -lh "$ARCHIVE"

echo
echo "Current Backups:"
ls -lh "$BACKUP_ROOT"