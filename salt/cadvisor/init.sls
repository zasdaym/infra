cadvisor:
  docker_container.running:
    - image: gcr.io/cadvisor/cadvisor:v0.47.2
    - binds:
        - /:/rootfs:ro
        - /var/run:/var/run:ro
        - /sys:/sys:ro
        - /var/lib/docker:/var/lib/docker:ro
        - /dev/disk:/dev/disk:ro
    - command:
        - --docker_only
        - --housekeeping_interval 55s
    - network_mode: host
    - privileged: true

/opt/stacks/victoriametrics/targets/cadvisor.yaml:
  file.managed:
    - contents: |
        - targets: [localhost:8080]
