pph21_container:
  docker_container.running:
    - name: pph21
    - image: ghcr.io/zasdaym/pph21
    - environment:
        - NODE_ENV=production
        - PORT=3001
    - network_mode: host
