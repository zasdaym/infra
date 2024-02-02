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

state_cron:
  cron.present:
    - identifier: state_cron
    - name: cd /tmp/infra && git pull && rsync --delete --recursive salt/ /srv/salt/ && salt-call --local state.apply
    - minute: "*/3"
