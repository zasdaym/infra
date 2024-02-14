victorialogs:
  docker_container.running:
    - image: victoriametrics/victoria-logs:v0.4.2-victorialogs
    - binds:
        - /opt/stacks/victorialogs/data:/victoria-logs-data
    - network_mode: host
