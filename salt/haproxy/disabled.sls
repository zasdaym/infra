haproxy_disabled:
  docker_container.absent:
    - name: haproxy
    - force: true
