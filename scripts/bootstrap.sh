#!/usr/bin/env bash
#
# Bootstrap a server with opinionated configuration.

set -o errexit
set -o nounset
set -o pipefail

main() {
	timedatectl set-timezone Asia/Jakarta

	export DEBIAN_FRONTEND=noninteractive
	apt-get update
	apt-get install -y \
		coreutils \
		curl \
		dnsutils \
		docker.io \
		gpg \
		lsb-release \
		mtr \
		rsync \
		wget

	if [[ -f /usr/bin/nomad ]]; then
		return
	fi

	wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
	apt-get update
	apt-get install -y nomad

	cat<<-EOF >/etc/nomad.d/nomad.hcl
	data_dir = "/opt/nomad/data"

	acl {
		enabled = true
	}

	server {
		enabled = true
		bootstrap_expect = 1
	}

	client {
		enabled = true
	}

	plugin "docker" {
		config {
			allow_privileged = true
			volumes {
				enabled = true
			}
		}
	}
	systemctl enable nomad
	systemctl restart nomad
	EOF
}

main
