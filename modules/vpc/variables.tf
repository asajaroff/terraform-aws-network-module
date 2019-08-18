variable "cidr_block" {
  description = "CIDR Block to deploy the infraestructure. (e.g. `10.0.0.0/16`)"
  default = "10.0.0.0/16"
}

variable "common_tags" {
  description = "List of tags. (namespace, environment and team)"
}