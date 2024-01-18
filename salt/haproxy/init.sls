haproxy_config:
  file.managed:
    - name: /opt/stacks/haproxy/haproxy.cfg
    - source: salt://haproxy/files/haproxy.cfg
    - makedirs: true

haproxy_container:
  docker_container.running:
    - name: haproxy
    - image: haproxy:2.9.2
    - binds:
        - /opt/stacks/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro
    - network_mode: host
    - user: root
    - watch:
        - haproxy_config
