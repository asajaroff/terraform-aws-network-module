output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_s3_endpoint" {
  value = "${module.vpc_s3_endpoint.vpc_endpoint_s3}"
}

output "availability_zones" {
  value = "${data.aws_availability_zones.available.names}"
  sensitive = false
}

output "application_subnet_ids" {
  value = "${formatlist("%v", aws_subnet.application_subnets.*.id)}"
}


# output "elastic_ips" {
#   value = "${module.nat_subnets.elastic_ips}"
# }

# # output "elastic_ips_nat" {
# #  value = "${formatlist("%v", "${module.nat_subnets.module.eip[*].elastic_ips}")}"
# # }

# output "nat_subnets_id" {
#   value = "${formatlist("%v", module.nat_subnets.*.subnet_ids)}"
# }
# output "application_subnets_id" {
#   value = "${formatlist("%v", aws_subnet.application_subnets.*.id)}"
# }

