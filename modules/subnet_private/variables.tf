variable "tags" {
  description = "Map of common tags."
  type = "map"
}
variable "cidr_block" {
  description = "CIDR Block to deploy the infraestructure. (e.g. `10.0.0.0/16`)"
  default = "10.0.0.0/16"
}
variable "vpc_id" {
  description = "VPC ID"
}

variable "az_count" {
  description = "Amount of Availability Zones to deploy subnets in."
}

variable "availability_zones" {
  description = "Availability zone names"
  type = "list"
}

variable "availability_zone" {
  description = "Availability zone where to deploy this subnet"
}

variable "subnet_name" {
  description = "Name of the subnet to deploy."
  default = "private-subnet"
}

variable "description" {
  description = "Description fro the subnet"
  default     = "Private Subnet"
}


variable "subnet_prefix" {
  description = "Prefix of this type of subnet (e.g. `private`, `application`)"
}

# variable "subnet_count" {
#   description = "Starting count for the subnet index)"
# }
# CIDR Subnet Calculation
# cidrsubnet(prefix, newbits, netnum)

# cidrsubnet calculates a subnet address within given IP network address prefix.
# cidrsubnet(prefix, newbits, netnum)
# prefix must be given in CIDR notation, as defined in RFC 4632 section 3.1.
# newbits is the number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20.
# netnum is a whole number that can be represented as a binary integer with no more than newbits binary digits, which will be used to populate the additional bits added to the prefix.
# This function accepts both IPv6 and IPv4 prefixes, and the result always uses the same addressing scheme as the given prefix.
# variable "cidrsubnet_prefix" {
#   description = "CIDR Block for Subnet Calculation"
# }

variable "cidrsubnet_newbits" {
  description = "The number of additional bits with which to extend the prefix"
}

# variable "cidrsubnet_netnum" {
#   description = "netnum is a whole number that can be represented as a binary integer with no more than newbits binary digits, which will be used to populate the additional bits added to the prefix."
# }

variable "nat_rtb" {
  description = "Route table ID to route traffic to internet through NAT gateway."
}