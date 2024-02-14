/opt/stacks/victoriametrics/prometheus.yml:
  file.managed:
    - makedirs: true
    - source: salt://victoriametrics/files/prometheus.yml

victoriametrics:
  docker_container.running:
    - image: victoriametrics/victoria-metrics:v1.93.10
    - binds:
        - /opt/stacks/victoriametrics/prometheus.yml:/prometheus.yml:ro
        - /opt/stacks/victoriametrics/targets:/targets
        - /opt/stacks/victoriametrics/data:/victoria-metrics-data
    - command:
        - -promscrape.config=/prometheus.yml
    - environment:
        - VIRTUAL_HOST=metrics.zasdaym.my.id
        - VIRTUAL_PORT=8428
    - network_mode: host
    - watch:
        - /opt/stacks/victoriametrics/prometheus.yml
