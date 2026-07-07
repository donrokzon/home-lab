#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage:"
    echo "./logs.sh <stack-folder>"
    echo
    echo "Example:"
    echo "./logs.sh caddy"
    exit 1
fi

cd /opt/stacks/$1 || exit

docker compose logs -f
