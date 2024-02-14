haproxy:
  docker_container.running:
    - image: byjg/easy-haproxy:4.4.0
    - binds:
        - /var/run/docker.sock:/var/run/docker.sock:ro
    - environment:
        - EASYHAPROXY_DISCOVER=docker
        - EASYHAPROXY_LOG_LEVEL=DEBUG
        - HAPROXY_LOG_LEVEL=ERROR
    - network_mode: host
