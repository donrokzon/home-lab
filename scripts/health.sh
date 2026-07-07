#!/bin/bash

echo
echo "==========================================="
echo " DNCloud Health"
echo "==========================================="

echo
echo "Docker Containers"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"

echo
echo "Docker Images"

docker image ls

echo
echo "Disk"

df -h

echo
echo "Docker"

docker system df

echo
echo "Memory"

free -h

echo
echo "CPU"

uptime

echo
echo "Load"

cat /proc/loadavg

echo
echo "Networks"

docker network ls

echo
echo "Volumes"

docker volume ls