locals {
  name = lookup(var.common_tags, "Application", "default_name")
  environment = lookup(var.common_tags, "Environment", "default")
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
  tags   = merge(map(
    "Name", "${local.name}-${local.environment}-s3-endpoint"),
    var.common_tags)
}