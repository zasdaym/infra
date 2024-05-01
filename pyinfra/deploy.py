from pyinfra.operations import server

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
