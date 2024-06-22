job "victoriametrics" {
  group "victoriametrics" {
    task "victoriametrics" {
      driver = "docker"
      config {
        image        = "victoriametrics/victoria-metrics:v1.93.15"
        network_mode = "host"
        volumes = [
          "/srv/victoriametrics/data:/victoria-metrics-data",
          "/local/scrape.yaml:/scrape.yaml:ro"
        ]
        args = [
          "-httpListenAddr=127.0.0.1:8428",
          "-promscrape.config=/local/scrape.yaml"
        ]
      }
      resources {
        cpu    = 100
        memory = 128
      }
      template {
        destination = "/local/scrape.yaml"
        data        = <<-EOF
        scrape_configs:
        - job_name: node_exporter
          static_configs:
          - targets:
            - localhost:9100
        EOF
      }
    }
  }
}
