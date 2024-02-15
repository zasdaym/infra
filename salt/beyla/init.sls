/opt/stacks/beyla/beyla.yaml:
  file.managed:
    - source: beyla/files/beyla.yaml

beyla:
  docker_container.running:
    - image: grafana/beyla:1.2.1
    - binds:
        - /opt/stacks/beyla/beyla.yaml:/beyla.yaml:ro
    - environment:
        - BEYLA_CONFIG_PATH=/beyla.yaml
    - network_mode: host
    - pid_mode: host
    - privileged: true
    - watch:
        - /opt/stacks/beyla/beyla.yaml

/opt/stacks/victoriametrics/targets/beyla.yaml:
  file.managed:
    - contents: |
        - targets: [localhost:9091]

