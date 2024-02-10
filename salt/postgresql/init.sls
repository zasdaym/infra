postgresql_container:
  docker_container.running:
    - name: postgresql
    - image: postgres:16.1
    - binds:
        - /opt/stacks/postgresql/data:/var/lib/postgresql/data
    - environment:
        - POSTGRES_PASSWORD={{ pillar['postgresql']['password'] }}
    - network_mode: host
