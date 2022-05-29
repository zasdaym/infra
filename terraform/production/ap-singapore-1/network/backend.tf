terraform {
  backend "s3" {
    profile                     = "zasdaym-oci-management"
    bucket                      = "zasdaym-tfstate"
    key                         = "production/ap-singapore-1/networking/terraform.tfstate"
    region                      = "ap-singapore-1"
    endpoint                    = "https://ax2h0b1bvrzx.compat.objectstorage.ap-singapore-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }

  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}
