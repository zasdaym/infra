timezone_config:
  timezone.system:
    - name: Asia/Jakarta

sysctl_tcp_notsent_lowat:
  sysctl.present:
    - name: net.ipv4.tcp_notsent_lowat
    - value: 131072

snapd_purge:
  pkg.purged:
    - name: snapd

basic_install:
  pkg.installed:
    - pkgs:
        - aria2
        - btop
        - curl
        - dnsutils
        - mtr
        - tcptraceroute
        - vim
