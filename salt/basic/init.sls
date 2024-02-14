Asia/Jakarta:
  timezone.system: []

"net.ipv4.tcp_notsent_lowat":
  sysctl.present:
    - value: 131072

snapd:
  pkg.purged: []

tools:
  pkg.installed:
    - pkgs:
        - aria2
        - btop
        - curl
        - dnsutils
        - mtr
        - tcptraceroute
        - vim

croniter:
  pip.installed: []

state_apply:
  schedule.present:
    - function: state.apply
    - cron: '*/5 * * * *'
