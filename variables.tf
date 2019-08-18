# Tags
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
variable "owner" {
  description = "User who is building the Infraestructure. (e.g. `your@email.com` or `AutomationServiceAccount`)"
  default = "asajaroff@gmail.com"
}

# Network
variable "cidr_block" {
  description = "CIDR Block to deploy the infraestructure. (e.g. `10.0.0.0/16`)"
  default = "10.0.0.0/16"
}
variable "az_count" {
  description = "Amount of Availability Zones to deploy in."
}