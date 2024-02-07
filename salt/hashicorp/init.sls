hashicorp_repo:
  file.managed:
    - name: /etc/apt/sources.list.d/hashicorp.list
    - contents: "deb [trusted=yes] https://apt.releases.hashicorp.com {{ grains['oscodename'] }} main"
