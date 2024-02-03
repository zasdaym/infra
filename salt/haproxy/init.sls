haproxy_container:
  docker_container.running:
    - name: haproxy
    - image: byjg/easy-haproxy:4.4.0
    - binds:
        - /var/run/docker.sock:/var/run/docker.sock:ro
    - environment:
        - EASYHAPROXY_DISCOVER=docker
        - EASYHAPROXY_LOG_LEVEL=ERROR
        - CERTBOT_LOG_LEVEL=ERROR
        - HAPROXY_LOG_LEVEL=ERROR
    - network_mode: host
    - user: root
