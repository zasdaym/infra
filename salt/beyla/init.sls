beyla:
  docker_container.running:
    - image: grafana/beyla:v1.2.1
    - environment:
        - BEYLA_OPEN_PORT=80
        - BEYLA_PROMETHEUS_PORT=9091
    - network_mode: host

/opt/stacks/victoriametrics/targets/beyla.yaml:
  file.managed:
    - contents: |
        - targets: [localhost:9091]

