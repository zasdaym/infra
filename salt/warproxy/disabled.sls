warproxy_container:
  docker_container.absent:
    - name: warproxy
    - force: true
