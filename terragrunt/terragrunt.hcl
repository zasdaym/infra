skip = true

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  name                 = local.account_vars.locals.name
  compartment_ocid     = local.account_vars.locals.compartment_ocid
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
  backend      = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    profile                     = "zasdaym-oci"
    bucket                      = "zasdaym-tfstate"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    endpoint                    = "https://ax2h0b1bvrzx.compat.objectstorage.${local.region}.oraclecloud.com"
    region                      = local.region
    force_path_style            = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
