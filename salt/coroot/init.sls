coroot_node_agent_container:
  docker_container.running:
    - name: coroot-node-agent
    - image: ghcr.io/coroot/coroot-node-agent:1.18.0
    - binds:
        - /sys/kernel/debug:/sys/kernel/debug:rw
        - /sys/fs/cgroup:/host/sys/fs/cgroup:ro
    - command:
        - --cgroupfs-root=/host/sys/fs/cgroup
        - --disable-log-parsing
        - --listen=0.0.0.0:9000
    - network_mode: host
    - pid_mode: host
    - privileged: true
