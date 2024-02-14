/etc/apt/sources.list.d/hashicorp.list:
  file.managed:
    - contents: "deb [trusted=yes] https://apt.releases.hashicorp.com {{ grains['oscodename'] }} main"
