module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.4.0"

  compartment_id          = var.compartment_id
  vcn_name                = var.vcn_name
  vcn_dns_label           = var.vcn_dns_label
  create_internet_gateway = true
  create_nat_gateway      = true
}

resource "oci_core_subnet" "private" {
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = var.private_subnet

  display_name               = "${var.vcn_name}-private-subnet"
  dns_label                  = "private"
  route_table_id             = module.vcn.nat_route_id
  prohibit_public_ip_on_vnic = true
}

resource "oci_core_subnet" "public" {
  compartment_id = var.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = var.public_subnet

  display_name               = "${var.vcn_name}-public-subnet"
  dns_label                  = "public"
  route_table_id             = module.vcn.ig_route_id
  prohibit_public_ip_on_vnic = false
}
