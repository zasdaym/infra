/opt/stacks/pomerium/config.yaml:
  file.managed:
    - source: salt://pomerium/files/config.yaml
    - makedirs: true

pomerium:
  docker_container.running:
    - image: pomerium/pomerium:0-25-0
    - binds:
        - /opt/stacks/pomerium/config.yaml:/pomerium/config.yaml:ro
    - network_mode: host
    - watch:
        - pomerium_config
