# Homelab

## Requirements

- Docker
- Docker Compose
- Ubuntu 24.04

## Create network

```bash
docker network create arr_network
```

## Start ARR

```bash
cd arr-stack
docker compose up -d
```

## Start Caddy

```bash
cd ../caddy
docker compose up -d
```

## Start Beszel

```bash
cd ../beszel
docker compose up -d
```