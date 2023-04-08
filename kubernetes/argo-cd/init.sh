#!/usr/bin/env bash

set -o errexit

main() {
    local name="$(basename $(pwd))"

    helm dependency build --skip-refresh
    helm template "${name}" . \
        --create-namespace \
        --namespace "${name}" |
        kubectl apply --namespace "${name}" --force --filename -
}

main
