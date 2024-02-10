umami:
  docker_container.running:
    - image: ghcr.io/umami-software/umami:postgresql-v2.9.0
    - environment:
        - APP_SECRET: "{{ pillar['umami']['secret'] }}"
        - DATABASE_URL: "postgresql://postgres@localhost:5432/umami"
        - PGPASSWORD: "{{ pillar['postgresql']['password'] }}"
        - PORT: "3003"
        - VIRTUAL_HOST: analytics.zasdaym.my.id
        - VIRTUAL_PORT: "3003"
    - network_mode: host
