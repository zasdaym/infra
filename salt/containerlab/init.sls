containerlab:
  docker_container.running:
    - image: ghcr.io/srl-labs/clab:0.19.0
    - binds:
        - /etc/hosts:/etc/hosts
        - /var/lib/docker/containers:/var/lib/docker/containers
        - /var/run/docker.sock:/var/run/docker.sock
        - /var/run/netns:/var/run/netns
        - /opt/stacks/containerlab/data:/opt/stacks/containerlab/data
    - commands:
        - bash
    - network_mode: host
    - pid_mode: host
