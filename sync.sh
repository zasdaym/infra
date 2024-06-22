#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

main() {
    local -r base_dir="/srv/nomad"

    expected_jobs=$(ls "$base_dir" | grep .nomad.hcl | cut -d '.' -f 1)
    declare -A should_keep
    for job in $expected_jobs; do
        should_keep["$job"]=1
    done

    existing_jobs=$(nomad job status -short | awk 'NR>1 {print $1}')
    for job in $existing_jobs; do
        if [[ -n "${should_keep[$job]}" ]]; then
            continue
        fi
        nomad job stop -purge "$job"
    done

    for job in $expected_jobs; do
        nomad job run -verbose=false "${base_dir}/${job}.nomad.hcl"
    done
}

main $@
