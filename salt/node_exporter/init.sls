node_exporter:
  docker_container.running:
    - image: quay.io/prometheus/node-exporter
    - binds:
        - /:/host:ro,rslave
    - command:
        - --collector.processes
        - --path.rootfs=/host
    - network_mode: host
    - pid_mode: host

/opt/stacks/victoriametrics/targets/node_exporter.yaml:
  file.managed:
    - contents: |
        - targets: [localhost:9100]
