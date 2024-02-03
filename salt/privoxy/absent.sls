privoxy_container:
  docker_container.absent:
    - name: privoxy
    - force: true
