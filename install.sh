#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

main() {
	timedatectl set-timezone Asia/Jakarta

	export DEBIAN_FRONTEND=noninteractive
	apt-get update -qqy
	apt-get install -qqy \
		curl \
		dnsutils \
		docker.io \
		lsb-release \
		mtr \
		rsync \
		wget

	wget -qO /etc/apt/trusted.gpg.d/hashicorp.asc https://apt.releases.hashicorp.com/gpg
	echo "deb [trusted-by=/etc/apt/trusted.gpg.d/hashicorp.asc] https://apt.releases.hashicorp.com/ $(lsb_release -cs) main" >/etc/apt/sources.list.d/hashicorp.list
	apt-get update -qqy
	apt-get install -qqy nomad
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
	EOF
	systemctl enable --now nomad.service

	echo "Setup completed"
}

main
