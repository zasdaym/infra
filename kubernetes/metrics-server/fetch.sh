#!/usr/bin/env bash

set -o errexit

function main() {
    local helm_repo="https://kubernetes-sigs.github.io/metrics-server/"
    local chart_name="metrics-server"
    local chart_version="3.9.0"

    helm pull \
        --repo "${helm_repo}" \
        --version "${chart_version}" \
        --untar \
        "${chart_name}"

    cp "${chart_name}/Chart.yaml" .
    cp -r "${chart_name}/templates" .
    rm -r "${chart_name}"
    rm -r "${chart_name}-${chart_version}.tgz"
}

main
