variable "service" {
  description = "The service name, in the form com.amazonaws.region.service for AWS services."
}
variable "vpc_id" {
  description = "The VPC ID to create in."
}

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