variable "availability_domain" {
  type        = string
  description = "the availability domain for the created instance"
}

variable "compartment_id" {
  type        = string
  description = "compartment id where to create all resources"
}

variable "shape" {
  type        = string
  description = "shape of the instance"
  default     = "VM.Standard.A1.Flex"
}

variable "cpu" {
  type        = number
  description = "instance cpu core"
  default     = 1
}

variable "memory" {
  type        = number
  description = "instance memory in GB"
  default     = 1
}

variable "display_name" {
  type        = string
  description = "display name of the instance"
}

variable "subnet_id" {
  type        = string
  description = "subnet id where to create the instance"
}

variable "image_id" {
  type        = string
  description = "image id to be used by the instance"
  default     = ""
}

variable "user_data" {
  type        = string
  description = "base64-encoded cloud-init user data"
  default     = ""
}
