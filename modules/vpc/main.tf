locals {
  name = lookup(var.common_tags, "Application", "default_name")
  environment = lookup(var.common_tags, "Environment", "default")
}


resource "aws_vpc" "main" {
  cidr_block            = var.cidr_block
  instance_tenancy      = "default"
  enable_dns_hostnames  = true
  enable_dns_support    = true
  tags                  = merge(map(
    "Name", "${local.name}-${local.environment}-vpc"),
    var.common_tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(map(
    "Name", "${local.name}-${local.environment}-main-igw"),
    var.common_tags)
}

