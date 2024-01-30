node_exporter_container:
  docker_container.running:
    - name: node_exporter
    - image: quay.io/prometheus/node-exporter
    - binds:
        - /:/host:ro,rslave
    - command:
        - --collector.processes
        - --path.rootfs=/host
    - network_mode: host
    - pid_mode: host

node_exporter_monitoring:
  file.managed:
    - name: /opt/stacks/victoriametrics/targets/node_exporter.yaml
    - contents: |
        - targets: [localhost:9100]
