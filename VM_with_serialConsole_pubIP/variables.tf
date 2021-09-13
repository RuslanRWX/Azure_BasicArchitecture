variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  type = string
  default = "terra"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type = string
  default = "West Europe"
}
variable "resource" {
  description = "The Azure Resource"
  type = string
  default = "kloomba-rg"
}

variable "subscription_id" {
  description = "description"

}

variable "client_id" {
  description = "description"

}

variable "client_secret" {
  description = "description"

}

variable "tenant_id" {
  description = "description"

}

