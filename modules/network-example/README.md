# Network Example Module

This module demonstrates Terraform module best practices for the Module Master challenge.

## Usage

```hcl
module "network" {
  source = "./modules/network-example"

  environment  = "production"
  vpc_cidr     = "10.0.0.0/16"
  subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  tags = {
    Project = "terraform-ctf"
  }
}