
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  version         = ">= 2.0"
  features {}

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


