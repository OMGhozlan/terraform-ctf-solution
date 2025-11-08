output "vpc_id" {
  description = "The ID of the VPC"
  value       = null_resource.vpc.triggers.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = null_resource.vpc.triggers.cidr_block
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = [for subnet in null_resource.subnets : subnet.triggers.subnet_id]
}

output "subnet_cidrs" {
  description = "List of subnet CIDR blocks"
  value       = [for subnet in null_resource.subnets : subnet.triggers.cidr_block]
}

output "route_table_id" {
  description = "The ID of the main route table"
  value       = null_resource.route_table.triggers.route_table_id
}

output "network_acl_id" {
  description = "The ID of the network ACL"
  value       = null_resource.network_acl.triggers.nacl_id
}

output "network_summary" {
  description = "Complete network configuration summary"
  value       = local.network_summary
}

output "environment" {
  description = "The environment this network is deployed in"
  value       = var.environment
}