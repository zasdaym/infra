job "node-exporter" {
  group "node-exporter" {
    task "node-exporter" {
      driver = "docker"
      config {
        image        = "quay.io/prometheus/node-exporter:v1.8.1"
        network_mode = "host"
        pid_mode     = "host"
        volumes = [
          "/:/host:ro,rslave"
        ]
        args = [
          "--web.listen-address=127.0.0.1:9100",
          "--path.rootfs=/host"
        ]
      }
      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
