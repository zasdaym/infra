data "oci_core_images" "ubuntu" {
  compartment_id           = var.compartment_id
  shape                    = var.shape
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "20.04"
}

resource "oci_core_instance" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.shape
  display_name        = var.display_name

  shape_config {
    ocpus         = var.cpu
    memory_in_gbs = var.memory
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id != "" ? var.image_id : data.oci_core_images.ubuntu.images[0].id
  }

  create_vnic_details {
    subnet_id = var.subnet_id
  }

  metadata = {
    user_data = var.user_data
  }
}

data "cloudflare_zone" "this" {
  count = var.enable_domain_mapping ? 1 : 0

  name = var.base_domain_name
}

resource "cloudflare_record" "this" {
  count = var.enable_domain_mapping ? 1 : 0

  zone_id = data.cloudflare_zone.this[0].id
  name    = var.sub_domain_name
  type    = "A"
  value   = oci_core_instance.this.public_ip
}
