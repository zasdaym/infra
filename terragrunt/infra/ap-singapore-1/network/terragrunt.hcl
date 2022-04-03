include "root" {
  path   = find_in_parent_folders("terragrunt.hcl")
  expose = true
}

terraform {
  source = "../../../modules/network//."
}

inputs = {
  compartment_id          = include.root.locals.compartment_ocid
  vcn_name                = include.root.locals.name
  vcn_dns_label           = include.root.locals.name
  vcn_cidrs               = ["10.0.0.0/16"]
  private_subnet          = "10.0.0.0/24"
  public_subnet           = "10.0.255.0/24"
  create_internet_gateway = true
  create_nat_gateway      = true
}
