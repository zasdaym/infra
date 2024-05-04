from pyinfra.context import host
from pyinfra.facts.files import File
from pyinfra.operations import files, server

server.shell(
    commands=[
        "timedatectl set-timezone Asia/Jakarta",
    ]
)

# HTTP/2 prioritization
sysctl_settings = [
    ["net.core.default_qdisc", "fq"],
    ["net.ipv4.tcp_congestion_control", "bbr"],
    ["net.ipv4.tcp_notsent_lowat", "16384"],
]
for setting in sysctl_settings:
    server.sysctl(
        key=setting[0],
        value=setting[1],
        persist=True,
    )

server.packages(
    packages=[
        "btop",
        "curl",
        "dnsutils",
        "tcptraceroute",
        "mtr",
    ],
)

# tailscale_installed = host.get_fact(File, "/usr/bin/tailscale")
# if not tailscale_installed:
#     server.shell(
#         commands=[
#             "curl -fsSL https://tailscale.com/install.sh | sh",
#         ]
#     )
