resource "azurerm_network_security_group" "main" {
  name                = "main"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Prod"
  }
}