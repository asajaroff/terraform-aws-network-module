output "vpc_endpoint_s3" {
  value = "${aws_vpc_endpoint.s3_endpoint.id}"
}