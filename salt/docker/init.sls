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
