job "caddy" {
  group "caddy" {
    network {
      port "caddy" {}
    }
    task "caddy" {
      driver = "docker"
      config {
        image        = "caddy:2.8.4"
        network_mode = "host"
        args = [
          "caddy",
          "run",
          "--config=/local/Caddyfile",
          "--adapter=caddyfile",
        ]
        volumes = [
          "/srv/caddy/www:/www:ro",
        ]
      }
      env {
        VIRTUAL_HOST = "file.zasdaym.my.id"
        VIRTUAL_PORT = "$${NOMAD_PORT_caddy}"
      }
      resources {
        cpu    = 100
        memory = 512
      }
      template {
        destination = "/local/Caddyfile"
        data        = <<-EOF
        :{{ env "NOMAD_PORT_caddy" }} {
          root * /www/file.zasdaym.my.id
          file_server {
            browse
          }
        }
        EOF
      }
    }
  }
}
