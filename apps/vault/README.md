# Vault
- `vault.yaml` is a rendered version of helm chart `vault` from <https://helm.releases.hashicorp.com/>.
- `values.yaml` is kept to make future updates easier.
- To do changes, edit `values.yaml` and then run:
```
helm repo add hashicorp https:/helm.releases.hashicorp.com/
helm template vault hashicorp/vault --namespace vault -f values.yaml > vault.yaml
```
