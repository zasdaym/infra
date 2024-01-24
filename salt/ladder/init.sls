ladder_container:
  docker_container.running:
    - name: ladder
    - image: ghcr.io/everywall/ladder:v0.0.21
    - network_mode: host
    - environment:
        - PORT=8082
