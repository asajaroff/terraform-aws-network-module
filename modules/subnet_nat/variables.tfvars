cidr_block = "172.22.32.0/20"
name = "private_subnet"
namespace = "example.com"
environment = "testing"
team        = "no_team"
vpc_id      = "vpc-0b1ec49f87e478136"
az_count    = 2
availability_zone = "us-east-1a"
subnet_name = "sample"
description = "AA"
subnet_prefix = "BB"
cidrsubnet_newbits = 2
availability_zones = [ "us-east-1a", "us-east-1b" ]



# Outputs:

# availability_zones = <sensitive>
# elastic_ips = [
#   "34.205.109.124",
#   "3.222.3.214",
# ]
# vpc_id = vpc-0b1ec49f87e478136
# vpc_s3_endpoint = vpce-040719c8428bc4059