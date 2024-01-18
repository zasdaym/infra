cadvisor_container:
  docker_container.running:
    - name: cadvisor
    - image: zcube/cadvisor:v0.45.0
    - binds:
        - /:/rootfs:ro
        - /var/run:/var/run:ro
        - /sys:/sys:ro
        - /var/lib/docker:/var/lib/docker:ro
        - /dev/disk:/dev/disk:ro
    - network_mode: host
    - privileged: true
