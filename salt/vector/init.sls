/opt/stacks/vector/vector.toml:
  file.managed:
    - makedirs: true
    - source: salt://vector/files/vector.toml

vector:
  docker_container.running:
    - image: timberio/vector:0.35.0-debian
    - binds:
        - /var/run/docker.sock:/var/run/docker.sock:ro
        - /var/lib/docker:/var/lib/docker:ro
        - /opt/stacks/vector/vector.toml:/etc/vector/vector.toml:ro
    - command:
        - --config=/etc/vector/vector.toml
    - network_mode: host
    - watch:
        - /opt/stacks/vector/vector.toml
