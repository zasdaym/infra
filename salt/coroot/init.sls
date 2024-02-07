coroot_container:
  docker_container.running:
    - name: coroot
    - image: ghcr.io/coroot/coroot:0.28.2
    - binds:
        - /opt/stacks/coroot/data:/data
    - command:
        - --listen=127.0.0.1:9090
    - environment:
        - VIRTUAL_HOST=coroot.zasdaym.my.id
        - VIRTUAL_PORT=9090
    - network_mode: host

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
        - --listen=127.0.0.1:9000
    - network_mode: host
    - pid_mode: host
    - privileged: true

coroot_node_agent_monitoring:
  file.managed:
    - name: /opt/stacks/victoriametrics/targets/coroot-node-agent.yaml
    - contents: |
        - targets: [localhost:9000]
