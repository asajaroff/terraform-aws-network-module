variable "name" {
  description = "Name of our application / project"
  default = "project"
}

variable "namespace" {
  description = "Namespace/domain of the application."
  default = "example.com"
}
variable "environment" {
  description = "Environment to deploy. (e.g. `prod` `staging` `testing` `develop` `sandbox`)"
  default = "sandbox"
}
variable "team" {
  description = "Team owner of the Application (e.g. `backend` `frontend` `billing`)"
  default = "sandbox"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "az_count" {
  description = "Amount of Availability Zones to deploy subnets in."
}