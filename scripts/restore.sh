#!/bin/bash

set -Eeuo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo:"
    echo "sudo ./restore.sh <backup.tar.gz>"
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo
    echo "Usage:"
    echo "sudo ./restore.sh <backup.tar.gz>"
    exit 1
fi

BACKUP="$1"

if [[ ! -f "$BACKUP" ]]; then
    echo "Backup file not found."
    exit 1
fi

echo
echo "==========================================="
echo " DNCloud Restore"
echo "==========================================="

echo
echo "Stopping all Docker stacks..."

for dir in /opt/stacks/*; do
    if [[ -f "$dir/docker-compose.yml" ]]; then
        (
            cd "$dir"
            docker compose down
        )
    fi
done

echo
echo "Extracting backup..."

TMP=$(mktemp -d)

tar -xzf "$BACKUP" -C "$TMP"

echo
echo "Restoring stacks..."

rsync -aHAX --delete \
"$TMP"/*/stacks/ \
/opt/stacks/

echo
echo "Restoring appdata..."

rsync -aHAX --delete \
"$TMP"/*/appdata/ \
/data/appdata/

echo
echo "Starting Docker stacks..."

for dir in /opt/stacks/*; do
    if [[ -f "$dir/docker-compose.yml" ]]; then
        (
            cd "$dir"
            docker compose up -d
        )
    fi
done

rm -rf "$TMP"

echo
echo "Restore completed successfully."