warproxy_container:
  docker_container.running:
    - name: warproxy
    - image: warproxy
    - environment:
        - HTTP_PORT=1081
    - network_mode: host
