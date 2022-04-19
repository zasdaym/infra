skip = true

locals {
  backend_region   = "ap-singapore-1"
  backend_endpoint = "https://ax2h0b1bvrzx.compat.objectstorage.ap-singapore-1.oraclecloud.com"

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  name                 = local.account_vars.locals.name
  compartment_id       = local.account_vars.locals.compartment_id
  region               = local.region_vars.locals.region
  availability_domains = local.region_vars.locals.availability_domains

}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "oci" {
  region = "${local.region}"
}
EOF
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    profile                     = "zasdaym-oci-management"
    bucket                      = "zasdaym-tfstate"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    endpoint                    = local.backend_endpoint
    region                      = local.backend_region
    force_path_style            = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
)
