locals {
  name = lookup(var.common_tags, "Application", "default_name")
  environment = lookup(var.common_tags, "Environment", "default")
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet("${var.cidr_block}", 2, count.index)
  count             = var.az_count
  availability_zone = var.availability_zones[count.index]
  tags   = merge(map(
    "Name", "${var.subnet_prefix}-${local.name}-${local.environment}-${var.availability_zones[count.index]}"
    "Description", "${var.description}",
    "Availability Zone", "${var.availability_zones.availability_zone[count.index]}")
    var.common_tags)
}

resource "aws_route_table_association" "nat" {
  subnet_id      = aws_subnet.private_subnet[count.index].subnet_id
  route_table_id = var.nat_rtb[count.index]
}
