docker_key:
  file.managed:
    - name: /etc/apt/keyrings/docker.asc
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: true

docker_repo:
  pkgrepo.managed:
    - name: deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
    - file: /etc/apt/sources.list.d/docker.list

docker_install:
  pkg.installed:
    - name: docker-ce

docker_pip:
  pip.installed:
    - name: docker

docker_config:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://docker/files/daemon.json

docker_service:
  service.running:
    - name: docker
    - watch:
        - docker_config

