include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "network" {
  config_path = "../network"
}

terraform {
  source = "${path_relative_from_include()}/modules//instance"
}

inputs = {
  compartment_id      = include.root.locals.compartment_ocid
  availability_domain = include.root.locals.availability_domains[0]
  subnet_id           = dependency.network.outputs.public_subnet_id
  display_name        = "node-01"
  shape               = "VM.Standard.E2.1.Micro"
  cpu                 = 1
  memory              = 1
  user_data           = base64encode(file("user-data.yaml"))
}
