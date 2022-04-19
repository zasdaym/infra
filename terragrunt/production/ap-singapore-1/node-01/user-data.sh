#!/usr/bin/env bash

useradd -m -s /bin/bash zasda

sudo -u zasda ssh-import-id gh:zasdaym

cat << EOF > /etc/sudoers.d/10-zasda
zasda ALL=(ALL) NOPASSWD:ALL
EOF

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade --yes
apt-get install --yes docker.io docker-compose

adduser zasda docker

mkdir -p /home/zasda/docker/adguard/adguard
mkdir -p /home/zasda/docker/adguard/caddy/config
mkdir -p /home/zasda/docker/adguard/caddy/data

cat << 'EOF' > /home/zasda/docker/adguard/caddy/config/Caddyfile
dns.zasdaym.my.id {
  handle /dns-query {
    reverse_proxy https://adguard {
      transport http {
        tls_insecure_skip_verify
      }
    }
  }

  handle {
    reverse_proxy http://adguard:3000
  }
}
EOF

cat << 'EOF' > /home/zasda/docker/adguard/docker-compose.yaml
version: '3.7'

services:
  caddy:
    image: caddy:2.4.6-alpine
  ports:
    - 80:80
    - 443:443
  volumes:
    - ./caddy/config:/etc/caddy
    - ./caddy/data:/data

  adguard:
    image: adguard/adguardhome:v0.107.6
    volumes:
      - ./adguard/config:/opt/adguardhome/conf
      - ./adguard/data:/opt/adguardhome/work
      - ./caddy/data:/opt/caddy-data
EOF

cd /home/zasda/docker/adguard
docker-compose up -d
