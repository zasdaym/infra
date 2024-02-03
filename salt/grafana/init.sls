grafana_container:
  docker_container.running:
    - name: grafana
    - image: grafana/grafana-oss:10.2.3
    - binds:
        - /opt/stacks/grafana/data:/var/lib/grafana
    - labels:
        - easyhaproxy.http.host=grafana.zasdaym.my.id
        - easyhaproxy.http.port=80
        - easyhaproxy.http.localport=3000
    - network_mode: host
    - user: root
