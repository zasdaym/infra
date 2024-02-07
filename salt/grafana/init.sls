grafana_container:
  docker_container.running:
    - name: grafana
    - image: grafana/grafana-oss:10.2.3
    - binds:
        - /opt/stacks/grafana/data:/var/lib/grafana
    - environment:
        - VIRTUAL_HOST=grafana.zasdaym.my.id
        - VIRTUAL_PORT=3000
    - labels:
        - easyhaproxy.grafana.host=grafana.zasdaym.my.id
        - easyhaproxy.grafana.localport=3000
    - network_mode: host
    - user: root
