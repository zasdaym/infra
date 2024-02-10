postgresql_container:
  docker_container.absent:
    - name: postgresql
    - force: true
