variable "vpc_id" {
  description = "The VPC ID to create in."
}
variable "common_tags" {
  description = "Map of tags. (namespace, environment and team)"
  type = "map"
}