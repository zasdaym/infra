ladder_container:
  docker_container.running:
    - name: ladder
    - image: ghcr.io/everywall/ladder:v0.0.21
    - network_mode: host
    - environment:
        - HTTP_PORT=http://localhost:8118
        - PORT=5000
        - USER_AGENT=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36
