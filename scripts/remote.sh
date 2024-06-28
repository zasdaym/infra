#!/usr/bin/env bash
#
# Execute local shell script on remote server.

set -o errexit
set -o nounset
set -o pipefail

main() {
	local -r target="$1"
	local -r script="$2"
	local -r script_name=$(basename $script)
	rsync -a "$script" "$target:/tmp/$script_name"
	ssh "$target" "/tmp/$script_name"
	ssh "$target" "rm /tmp/$script_name"
}

main $@
