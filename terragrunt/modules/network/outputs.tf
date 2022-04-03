output "vcn_id" {
  value       = module.vcn.vcn_id
  description = "id of vcn that is created"
}

output "nat_gateway_id" {
  description = "id of nat gateway if it is created"
  value       = module.vcn.nat_gateway_id
}

output "internet_gateway_id" {
  description = "id of internet gateway if it is created"
  value       = module.vcn.internet_gateway_id
}

output "private_subnet_id" {
  description = "id of private subnet"
  value       = oci_core_subnet.private.id
}

output "public_subnet_id" {
  description = "id of public subnet"
  value       = oci_core_subnet.public.id
}
