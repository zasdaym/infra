privoxy_container:
  docker_container.running:
    - name: privoxy
    - image: dockage/tor-privoxy
    - network_mode: host
