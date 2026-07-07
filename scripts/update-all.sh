#!/bin/bash

set -e

echo
echo "==========================================="
echo "🚀 Updating Homelab"
echo "==========================================="

for dir in /opt/stacks/*; do
    if [ -f "$dir/docker-compose.yml" ]; then
        echo
        echo "📦 $(basename "$dir")"

        (
            cd "$dir"

            docker compose pull
            docker compose up -d --remove-orphans
        )
    fi
done

echo
echo "🧹 Cleaning unused images..."
docker image prune -f

echo
echo "📊 Disk usage:"
docker system df

echo
echo "✅ Homelab update complete!"