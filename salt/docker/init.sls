/etc/apt/keyrings/docker.asc:
  file.managed:
    - skip_verify: true
    - source: https://download.docker.com/linux/ubuntu/gpg

deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/docker.list

docker-ce:
  pkg.installed: []

docker:
  pip.installed: []
  service.running:
    - enable: true
    - watch:
        - /etc/docker/daemon.json

/etc/docker/daemon.json:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://docker/files/daemon.json
