locals {
  region         = "ap-singapore-1"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaazyh67q4sibrsghrovolmusycgv4keos7hao5xnmdyl4tcdxn6cmq"
}

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.4.0"

  region                  = local.region
  compartment_id          = local.compartment_id
  create_internet_gateway = true
  create_nat_gateway      = false
  vcn_cidrs               = ["10.0.0.0/16"]
  vcn_name                = "production"
}

resource "oci_core_security_list" "private" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id

  display_name = "private"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
}

resource "oci_core_security_list" "public" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id

  display_name = "public"

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"

    tcp_options {

      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"

    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
}

resource "oci_core_subnet" "private" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.0.0/24"

  display_name               = "private"
  dns_label                  = "private"
  route_table_id             = module.vcn.nat_route_id
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private.id]
}

resource "oci_core_subnet" "public" {
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = "10.0.128.0/24"

  display_name               = "public"
  dns_label                  = "public"
  route_table_id             = module.vcn.ig_route_id
  prohibit_public_ip_on_vnic = false
  security_list_ids          = [oci_core_security_list.public.id]
}
