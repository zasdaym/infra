vector_config:
  file.managed:
    - name: /opt/stacks/vector/vector.toml
    - source: salt://vector/files/vector.toml
    - makedirs: true

vector_container:
  docker_container.running:
    - name: vector
    - image: timberio/vector:0.35.0-debian
    - binds:
        - /var/run/docker.sock:/var/run/docker.sock:ro
        - /var/lib/docker:/var/lib/docker:ro
        - /opt/stacks/vector/vector.toml:/etc/vector/vector.toml:ro
    - command:
        - --config=/etc/vector/vector.toml
    - network_mode: host
    - watch:
        - vector_config
