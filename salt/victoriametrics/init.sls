victoriametrics_config:
  file.managed:
    - name: /opt/stacks/victoriametrics/prometheus.yml
    - source: salt://victoriametrics/files/prometheus.yml

victoriametrics_container:
  docker_container.running:
    - name: victoriametrics
    - image: victoriametrics/victoria-metrics:v1.93.10
    - command:
        - -promscrape.config=/prometheus.yml
    - binds:
        - /opt/stacks/victoriametrics/prometheus.yml:/prometheus.yml:ro
        - /opt/stacks/victoriametrics/targets:/targets
        - /opt/stacks/victoriametrics/data:/victoria-metrics-data
    - network_mode: host
    - watch:
        - victoriametrics_config
