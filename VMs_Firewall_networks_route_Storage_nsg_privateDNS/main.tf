resource "azurerm_resource_group" "terra-rg" {
    name = "Terra-RG"
    location = "eastus"
    tags = { 
        Owner = "TR"
    } 
}

resource "azurerm_resource_group" "terra-rg-second" {
    name = "Terra-RG-second"
    location = "eastus"
    tags = { 
        Owner = "TR-second"
    } 
}

variable "prefix" {
  default = "tr"
}
/*
output "prefix" {
  value = "prefix"
}
*/
