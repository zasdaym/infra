umami:
  docker_container.running:
    - image: ghcr.io/umami-software/umami:postgresql-latest
    - environment:
        - APP_SECRET: "{{ pillar['umami']['secret'] }}"
        - DATABASE_URL: "host=localhost port=5432 database=umami user=postgres password={{ pillar['postgresql']['password'] }}"
        - DATABASE_TYPE: postgresql
        - PORT: "3003"
        - VIRTUAL_HOST: analytics.zasdaym.my.id
        - VIRTUAL_PORT: "3003"
    - network_mode: host
