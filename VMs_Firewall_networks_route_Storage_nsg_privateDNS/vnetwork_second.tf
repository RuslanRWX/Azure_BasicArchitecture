/*
resource "azurerm_virtual_network" "second" {
  name                = "terra-rg-network-second"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.terra-rg-second.location
  resource_group_name = azurerm_resource_group.terra-rg-second.name
}

resource "azurerm_subnet" "internal_second" {
  name                 = "${var.prefix}-internal_second"
  resource_group_name  = azurerm_resource_group.terra-rg-second.name
  virtual_network_name = azurerm_virtual_network.second.name
  address_prefixes     = ["10.2.10.0/24"]
}
*/
