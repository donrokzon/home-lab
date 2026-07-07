#!/bin/bash

echo
echo "=========================================="
echo " Docker Cleanup"
echo "=========================================="

docker image prune -f
docker container prune -f
docker network prune -f
docker builder prune -f

echo
docker system df
