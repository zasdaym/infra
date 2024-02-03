/etc/apt/sources.list.d/netdevops.list:
  file.managed:
    - contents: deb [trusted=yes] https://apt.fury.io/netdevops/ /

containerlab:
  pkg.installed: []
