locals {
  # Generate a network summary
  network_summary = jsonencode({
    vpc = {
      id   = null_resource.vpc.triggers.vpc_id
      cidr = var.vpc_cidr
    }
    subnets = [
      for idx, subnet in null_resource.subnets :
      {
        id   = subnet.triggers.subnet_id
        cidr = subnet.triggers.cidr_block
        az   = subnet.triggers.az
      }
    ]
    route_table = {
      id = null_resource.route_table.triggers.route_table_id
    }
    network_acl = {
      id = null_resource.network_acl.triggers.nacl_id
    }
  })

  # Common tags for all resources
  common_tags = merge(
    var.tags,
    {
      Module      = "network-example"
      Environment = var.environment
    }
  )
}

# Simulated VPC resource (using null_resource as placeholder)
resource "null_resource" "vpc" {
  triggers = {
    vpc_id      = "vpc-${md5("${var.environment}-${var.vpc_cidr}")}"
    cidr_block  = var.vpc_cidr
    environment = var.environment
    created_at  = timestamp()
  }
}

# Simulated subnet resources
resource "null_resource" "subnets" {
  count = length(var.subnet_cidrs)

  triggers = {
    subnet_id   = "subnet-${md5("${var.environment}-${var.subnet_cidrs[count.index]}")}"
    vpc_id      = null_resource.vpc.triggers.vpc_id
    cidr_block  = var.subnet_cidrs[count.index]
    az          = "az-${count.index + 1}"
    environment = var.environment
    index       = count.index
  }

  depends_on = [null_resource.vpc]
}

# Simulated route table
resource "null_resource" "route_table" {
  triggers = {
    route_table_id = "rtb-${md5("${var.environment}-main")}"
    vpc_id         = null_resource.vpc.triggers.vpc_id
    environment    = var.environment
  }

  depends_on = [null_resource.vpc]
}

# Network ACL
resource "null_resource" "network_acl" {
  triggers = {
    nacl_id     = "acl-${md5("${var.environment}-default")}"
    vpc_id      = null_resource.vpc.triggers.vpc_id
    environment = var.environment
  }

  depends_on = [null_resource.vpc]
}