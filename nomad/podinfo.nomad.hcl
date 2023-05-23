job "podinfo" {

  group "podinfo" {
    count = 2

    network {
      port "http" {}
    }

    service {
      name     = "podinfo"
      provider = "nomad"
      port     = "http"
    }

    task "podinfo" {
      driver = "docker"

      config {
        image        = "stefanprodan/podinfo:6.3.6"
        network_mode = "host"
      }

      resources {
        cpu    = 100
        memory = 128
      }

      env {
        PODINFO_PORT = "${NOMAD_PORT_http}"
      }
    }
  }
}
