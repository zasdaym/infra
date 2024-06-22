job "nginx" {
  group "nginx" {
    task "nginx" {
      driver = "docker"
      config {
        image        = "nginxproxy/nginx-proxy:1.6.0"
        network_mode = "host"
        volumes = [
          "/var/run/docker.sock:/tmp/docker.sock:ro"
        ]
      }
      env {
        TRUST_DOWNSTREAM_PROXY = "true"
      }
      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
