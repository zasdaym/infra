variable "compartment_id" {
  description = "compartment id where to create all resources"
  type        = string
}

variable "vcn_cidrs" {
  description = "The list of IPv4 CIDR blocks the VCN will use."
  default     = ["10.0.0.0/16"]
  type        = list(string)
}

variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
  default     = "vcnmodule"

  validation {
    condition     = length(regexall("^[^0-9][a-zA-Z0-9_]+$", var.vcn_dns_label)) > 0
    error_message = "DNS label must be an alphanumeric string that begins with a letter."
  }
}

variable "vcn_name" {
  description = "user-friendly name of to use for the vcn to be appended to the label_prefix"
  type        = string
  default     = "vcn-module"
  validation {
    condition     = length(var.vcn_name) > 0
    error_message = "The vcn_name value cannot be an empty string."
  }
}

variable "create_internet_gateway" {
  description = "whether to create the internet gateway in the vcn. If set to true, creates an Internet Gateway."
  default     = false
  type        = bool
}

variable "create_nat_gateway" {
  description = "whether to create a nat gateway in the vcn. If set to true, creates a nat gateway."
  default     = false
  type        = bool
}

variable "private_subnet" {
  description = "the private subnet cidr, must be inside the vcn_cidrs"
  default     = "10.0.0.0/24"
  type        = string
}

variable "public_subnet" {
  description = "the public subnet cidr, must be inside the vcn_cidrs"
  default     = "10.0.255.0/24"
  type        = string
}
