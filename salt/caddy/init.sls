/opt/stacks/caddy/Caddyfile:
  file.managed:
    - makedirs: true
    - source: salt://caddy/files/Caddyfile

caddy:
  docker_container.running:
    - image: caddy:2.7.6
    - binds:
        - /opt/stacks/caddy/Caddyfile:/etc/caddy/Caddyfile:ro
        - /srv/www/file:/srv/www/file:ro
    - environment:
        - VIRTUAL_HOST=file.zasdaym.my.id
        - VIRTUAL_PORT=8082
    - network_mode: host
    - watch:
        - /opt/stacks/caddy/Caddyfile
