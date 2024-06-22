#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

main() {
	rsync -a ./nomad/ root@129.150.59.188:/srv/nomad/
	ssh root@129.150.59.188 <<-EOF
		find /srv/nomad -name "*.nomad.hcl" -exec nomad job run {} \;
	EOF
}

main $@
