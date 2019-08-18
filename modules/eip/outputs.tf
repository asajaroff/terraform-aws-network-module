output "elastic_ips" {
  value = "${formatlist("%v", aws_eip.main.*.public_ip)}"
}

output "eip_alloc_id" {
  value = "value"
  value = "${formatlist("%v", module.aws_eip.*.eip_alloc_id)}"
}
