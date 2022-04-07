output "private_ip" {
  value       = oci_core_instance.this.private_ip
  description = "instance private IP"
}

output "public_ip" {
  value       = oci_core_instance.this.public_ip
  description = "instance public IP"
}
