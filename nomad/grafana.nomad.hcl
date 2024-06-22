job "grafana" {
  group "grafana" {
    task "grafana" {
      driver = "docker"
      config {
        image        = "grafana/grafana-oss:11.0.0"
        network_mode = "host"
        volumes = [
          "/srv/grafana/data:/var/lib/grafana"
        ]
      }
      env {
        GF_PATHS_PROVISIONING = "/local/provisioning"
        GF_SERVER_HTTP_ADDR   = "127.0.0.1"
        VIRTUAL_HOST          = "grafana.zasdaym.my.id"
        VIRTUAL_PORT          = "3000"
      }
      resources {
        cpu    = 100
        memory = 128
      }
      user = "root"
      template {
        destination = "/local/provisioning/datasources/victoriametrics.yaml"
        data        = <<-EOF
        apiVersion: 1
        datasources:
        - name: VictoriaMetrics
          type: prometheus
          url: http://127.0.0.1:8428
        EOF
      }
    }
  }
}
