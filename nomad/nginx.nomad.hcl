job "nginx" {

  group "nginx" {

    task "nginx" {
      driver = "docker"

      config {
        image        = "nginxproxy/nginx-proxy:1.6.0"
        network_mode = "host"
        volumes = [
          "/var/run/docker.sock:/tmp/docker.sock:ro",
          "local/additional.conf:/etc/nginx/conf.d/additional.conf:ro",
          "/srv/nginx/www:/www:ro",
        ]
      }

      env {
        TRUST_DOWNSTREAM_PROXY = "true"
      }

      resources {
        cpu    = 100
        memory = 1024
      }

      template {
        destination = "local/additional.conf"
        data        = <<-EOF
          server {
            server_name _;
            location / {
              proxy_set_header host $host;
              proxy_pass http://0.0.0.0;
            }
          }

          server {
            server_name nomad.zasdaym.my.id;
            location / {
              proxy_set_header host $host;
              proxy_pass http://127.0.0.1:4646;
            }
          }

          server {
            server_name cml.zasdaym.my.id;
            location / {
              proxy_set_header host $host;
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_pass http://100.72.129.27;
            }
          }

          server {
            server_name file.zasdaym.my.id;
            root /www/file.zasdaym.my.id;
            location / {
              autoindex on;
              autoindex_exact_size off;
              autoindex_localtime on;
            }
          }
        EOF
      }
    }
  }
}
