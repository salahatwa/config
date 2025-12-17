#!/bin/bash
set -Eeuo pipefail

echo "🚀 Deployment started..."

# ---------- Helpers ----------
log() {
  echo "👉 $1"
}

# ---------- Docker socket permissions ----------
if [ -S /var/run/docker.sock ]; then
  sudo chmod 666 /var/run/docker.sock || true
else
  log "Docker socket not found, skipping chmod"
fi

# ---------- Docker network ----------
if ! sudo docker network inspect webnet >/dev/null 2>&1; then
  log "Creating docker network: webnet"
  sudo docker network create webnet
else
  log "Docker network 'webnet' already exists"
fi

# ---------- Clean old compose file ----------
if [ -f docker-compose.prod.yml ]; then
  log "Removing old docker-compose.prod.yml"
  rm -f docker-compose.prod.yml
fi


# ---------- Download required files ----------
log "Downloading docker-compose.prod.yml"
curl -fsSLO https://raw.githubusercontent.com/salahatwa/config/dynamic-platform/docker-compose.prod.yml

log "Downloading .env.production"
curl -fsSLO https://raw.githubusercontent.com/salahatwa/config/dynamic-platform/.env.production

# ---------- Stop running containers ----------
log "Stopping existing containers"
sudo docker compose -f docker-compose.prod.yml --env-file .env.production down || true

# ---------- Remove old image if exists ----------
if sudo docker images | grep -q "salahatwa2035/dynamic-platform-api"; then
  log "Removing old image"
  sudo docker rmi salahatwa2035/dynamic-platform-api:latest || true
else
  log "Docker image not found, skipping remove"
fi

# ---------- Pull & build ----------
log "Pulling images"
sudo docker compose -f docker-compose.prod.yml --env-file .env.production pull

log "Building images"
sudo docker compose -f docker-compose.prod.yml --env-file .env.production build

# ---------- Start services ----------
log "Starting containers"
sudo docker compose -f docker-compose.prod.yml --env-file .env.production up -d

echo "✅ Deployment completed successfully!"
