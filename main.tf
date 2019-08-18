terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = "~> 2.23"
  region  = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  common_tags = map(
    # "Name", "${var.name}-${var.environment}",
    "Namespace", "${var.namespace}",
    "Application", "${var.name}",
    "Environment", "${var.environment}",
    "Team", "${var.team}",
    "Owner", "${var.owner}")
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block  = var.cidr_block
#  name        = "${local.name}-vpc"
  common_tags = local.common_tags
}

module "vpc_s3_endpoint" {
  source      = "./modules/vpc_s3_endpoint"
  vpc_id      = module.vpc.vpc_id
 # name        = "${local.name}-s3-endpoint"
  common_tags = local.common_tags
}

locals {
  # CIDR size for nat_subnets is 172.22.40.0/23
  nat_cidr_block = cidrsubnet("${var.cidr_block}", 4 , 14 )
}


module "nat_subnets" {
  source              = "./modules/subnet_nat"
  az_count            = var.az_count
  cidr_block          = cidrsubnet("${local.nat_cidr_block}", 1 , 0)
  availability_zones  = data.aws_availability_zones.available.names
  availability_zone   = data.aws_availability_zones.available.names
  vpc_id              = module.vpc.vpc_id
  subnet_prefix       = "nat"
  cidrsubnet_newbits  = 2
  description         = "Public subnet with NAT Gateway associated with an elastic IP Address"
  route_table_id      = module.vpc.route_table_id
  igw_id              = module.vpc.igw_id
  common_tags         = local.common_tags
}

resource "aws_subnet" "application_subnets" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = cidrsubnet("${var.cidr_block}", 3, "${count.index}")
  count             = var.az_count
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name"        = "application-${var.name}-${data.aws_availability_zones.available.names[count.index]}"
    "Domain"      = "${var.namespace}"
    "Team"        = "${var.team}"
    "Environment" = "${var.environment}"
    "Description" = "Application Subnet, meant to run EKS Worker Nodes"
  }
}

resource "aws_route_table_association" "application_to_nat" {
  count          = var.az_count
  subnet_id      = aws_subnet.application_subnets[count.index].id
  route_table_id = module.nat_subnets.nat_rtb[count.index]
}

resource "aws_subnet" "persistence_subnets" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = cidrsubnet("${var.cidr_block}", 4, "${count.index + var.az_count + var.az_count + 2}")
  count             = var.az_count
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name"        = "persistence-${var.name}-${var.environment}-${data.aws_availability_zones.available.names[count.index]}"
    "Domain"      = "${var.namespace}"
    "Team"        = "${var.team}"
    "Environment" = "${var.environment}"
    "Description" = "Persistent Subnet, meant for persistence application data and storage."
  }
}

resource "aws_route_table_association" "persistence_to_nat" {
  count          = var.az_count
  subnet_id      = aws_subnet.persistence_subnets[count.index].id
  route_table_id = module.nat_subnets.nat_rtb[count.index]
}


# ## Instance for testing routing
# data "aws_ami" "ubuntu" {
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   owners = ["099720109477"] # Canonical
# }

# data "http" "myip" {
#   url = "http://ipv4.icanhazip.com"
# }

# resource "aws_security_group" "allow_ssh" {
#   name        = "allow_ssh"
#   description = "Allow SSH inbound traffic"
#   vpc_id      = module.vpc.vpc_id
#   ingress {
#     # TLS (change to whatever ports you need)
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     # Please restrict your ingress to only necessary IPs and ports.
#     # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
#     cidr_blocks = ["${chomp(data.http.myip.body)}/32"] # add your IP address here
#   }
#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "allow_ssh"
#   }
# }

# resource "aws_instance" "web" {
#   ami           = "${data.aws_ami.ubuntu.id}"
#   instance_type = "t2.micro"
#   subnet_id     = module.nat_subnets.subnet_ids[0]
#   tags = {
#     Name = "ec2-network-tester"
#   }
#   key_name        = "asajaroff-sandbox-us-east-1_2"
#   security_groups = ["${aws_security_group.allow_ssh.id}"]
#   depends_on = ["aws_security_group.allow_ssh"]
# }