provider "aws" {
  region = "us-east-1"
}

locals {
  name = lookup(var.common_tags, "Application", "default_name")
  environment = lookup(var.common_tags, "Environment", "default")
}

resource "aws_subnet" "nat_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet("${var.cidr_block}", 2, count.index)
  count                   = var.az_count
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags   = merge(map(
    "Name", "${var.subnet_prefix}-${local.name}-${local.environment}-${var.availability_zones[count.index]}"),
    var.common_tags)
}

resource "aws_eip" "nat" {
  vpc = true
  count = var.az_count
  tags   = merge(map(
    "Name", "eip-${local.name}-${local.environment}-${var.availability_zones[count.index]}"),
    var.common_tags)
}

resource "aws_nat_gateway" "instance" {
  count         = var.az_count
  subnet_id     = aws_subnet.nat_subnet[count.index].id
  allocation_id = "${aws_eip.nat[count.index].id}"
  tags   = merge(map(
    "Name", "natgw-${local.name}-${local.environment}-${var.availability_zones[count.index]}"),
    var.common_tags)
}

resource "aws_route" "public_internet_gateway" {
  count = var.az_count
  route_table_id         = aws_route_table.rt_internet[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table_association" "pub_to_int" {
  count          = var.az_count
  subnet_id      = aws_subnet.nat_subnet[count.index].id
  route_table_id = aws_route_table.rt_internet[count.index].id
}

resource "aws_route_table" "rt_nat" {
  count  = var.az_count
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.instance[count.index].id}"
  }
  tags   = merge(map(
    "Name", "rt-nat-${local.name}-${local.environment}-${var.availability_zones[count.index]}",
    "Description", "Traffic to Internet through NAT for ${var.availability_zones[count.index]}"),
    var.common_tags)
}

resource "aws_route_table" "rt_internet" {
  count  = var.az_count
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = var.igw_id
  }
  tags   = merge(map(
    "Name", "rt-nat-${local.name}-${local.environment}-${var.availability_zones[count.index]}",
    "Description", "Traffic to Internet through NAT for ${var.availability_zones[count.index]}"),
    var.common_tags)
}