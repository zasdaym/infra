nginx:
  docker_container.running:
    - image: nginxproxy/nginx-proxy:1.4
    - binds:
        - /var/run/docker.sock:/tmp/docker.sock:ro
    - network_mode: host
