output "elastic_ips" {
  value = "${formatlist("%v", aws_eip.nat.*.public_ip)}"
}
output "subnet_ids" {
  value = "${formatlist("%v", aws_subnet.nat_subnet.*.id)}"
}

output "ngw_ids" {
  value = "${formatlist("%v", aws_nat_gateway.instance.*.id)}"
}

output "nat_rtb" {
  value = "${formatlist("%v", aws_route_table.rt_nat.*.id)}"
}