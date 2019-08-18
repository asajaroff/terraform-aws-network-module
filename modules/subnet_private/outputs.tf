output "private_subnet_ids" {
  value = "${formatlist("%v", aws_subnet.private_subnet.*.id)}"
}