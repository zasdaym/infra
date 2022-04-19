terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.69.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.12.2"
    }
  }
}
