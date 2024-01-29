pomerium_config:
  file.managed:
    - name: /opt/stacks/pomerium/config.yaml
    - source: salt://pomerium/files/config.yaml
    - makedirs: true

pomerium_container:
  docker_container.running:
    - name: pomerium
    - image: pomerium/pomerium:0-25-0
    - binds:
        - /opt/stacks/pomerium/config.yaml:/pomerium/config.yaml:ro
    - network_mode: host
    - watch:
        - pomerium_config
