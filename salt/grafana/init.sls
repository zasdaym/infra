grafana_container:
  docker_container.running:
    - name: grafana
    - image: grafana/grafana-oss:10.2.3
    - binds:
        - /opt/stacks/grafana/data:/var/lib/grafana
    - network_mode: host
    - user: root
