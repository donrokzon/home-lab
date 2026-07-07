# DNCloud Homelab

Self-hosted media and infrastructure stack running on Ubuntu with Docker Compose.

---

## Services

- Caddy (Reverse Proxy)
- Beszel (Monitoring)
- Beszel Agent
- Radarr
- Sonarr
- Prowlarr
- Bazarr
- qBittorrent
- Jellyfin
- Jellyseerr
- FlareSolverr
- Recyclarr

---

## Directory Layout

```
/opt/stacks
    arr-stack
    beszel
    beszel-agent
    caddy
    scripts

/data
    appdata
    downloads
    media
    backups
```

---

## Docker Network

```bash
docker network create arr_network
```

---

## Start Services

### ARR Stack

```bash
cd /opt/stacks/arr-stack
docker compose up -d
```

### Caddy

```bash
cd /opt/stacks/caddy
docker compose up -d
```

### Beszel

```bash
cd /opt/stacks/beszel
docker compose up -d
```

### Beszel Agent

```bash
cd /opt/stacks/beszel-agent
docker compose up -d
```

---

## Update Everything

```bash
/opt/stacks/scripts/update-all.sh
```

---

## Health Check

```bash
/opt/stacks/scripts/health.sh
```

---

## Backup

```bash
sudo /opt/stacks/scripts/backup.sh
```

---

## Restore

```bash
sudo /opt/stacks/scripts/restore.sh <backup.tar.gz>
```

---

## Repository

Configuration only.

Runtime data is stored under:

```
/data/appdata
```

No application data is committed to Git.