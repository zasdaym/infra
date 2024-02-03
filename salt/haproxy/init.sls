haproxy_container:
  docker_container.running:
    - name: haproxy
    - image: byjg/easy-haproxy:4.4.0
    - environment:
        - EASYHAPROXY_DISCOVER=docker
    - network_mode: host
    - user: root
