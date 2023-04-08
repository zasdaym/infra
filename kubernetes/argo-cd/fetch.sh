#!/usr/bin/env bash

set -o errexit

function main() {
    local helm_repo="https://argoproj.github.io/argo-helm"
    local chart_name="argo-cd"
    local chart_version="5.28.1"

    helm pull \
        --repo "${helm_repo}" \
        --version "${chart_version}" \
        --untar \
        "${chart_name}"

    cp "${chart_name}/Chart.yaml" .
    cp -r "${chart_name}/templates" .
    cp -n "${chart_name}/values.yaml" .
    rm -r "${chart_name}"
    rm -r "${chart_name}-${chart_version}.tgz"
}

main
