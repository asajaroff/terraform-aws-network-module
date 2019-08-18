output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "route_table_id" {
  value = "${aws_vpc.main.default_route_table_id}"
}


output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}