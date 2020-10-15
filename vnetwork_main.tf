#
resource "azurerm_virtual_network" "main" {
  name                = "terra-rg-network-main"
  address_space       = ["10.84.1.0/24"]
  location            = azurerm_resource_group.terra-rg.location
  resource_group_name = azurerm_resource_group.terra-rg.name
}
/*
resource "azurerm_subnet" "internal" {
  name                 = "${var.prefix}-internal"
  resource_group_name  = azurerm_resource_group.terra-rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.84.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "internal_sec_group" {
  subnet_id                 = azurerm_subnet.interna.id
  network_security_group_id = azurerm_network_security_group.main.id
}
*/

resource "azurerm_public_ip" "FireWall" {
    name                         = "${var.prefix}-PublicIP-FireWall"
    location                     = azurerm_resource_group.terra-rg.location
    resource_group_name          = azurerm_resource_group.terra-rg.name
    #allocation_method            = "Dynamic"
    allocation_method   = "Static"
    sku                 = "Standard"

    tags = {
        environment = "Terraform Demo",
        IP_type = "IP FW"
    }
}

resource "azurerm_public_ip" "loop" {
    for_each                     = toset(local.vms)
    name                         = "${var.prefix}-PublicIP-${each.key}"
    location                     = azurerm_resource_group.terra-rg.location
    resource_group_name          = azurerm_resource_group.terra-rg.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo",
        IP_type = "IP_LOOP"
    }
}

resource "azurerm_public_ip" "fw" {
    name                         = "${var.prefix}-PublicIP-fw"
    location                     = azurerm_resource_group.terra-rg.location
    resource_group_name          = azurerm_resource_group.terra-rg.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo",
        IP_type = "IP_fw"
    }
}

resource "azurerm_subnet" "common" {
  name                 = "common"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_resource_group.terra-rg.name
  address_prefixes     = ["10.84.1.96/27"]
}

resource "azurerm_subnet_network_security_group_association" "common_sec_group" {
  subnet_id                 = azurerm_subnet.common.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# AzureFirewallSubnet
resource "azurerm_subnet" "AzureFirewallSubnet" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_resource_group.terra-rg.name
  address_prefixes     = ["10.84.1.0/26"]
}

#resource "azurerm_subnet_network_security_group_association" "AzureFirewallSubnet_sec_group" {
#  subnet_id                 = azurerm_subnet.AzureFirewallSubnet.id
#  network_security_group_id = azurerm_network_security_group.main.id
#}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_resource_group.terra-rg.name
  address_prefixes     = ["10.84.1.64/27"]
}

#resource "azurerm_subnet_network_security_group_association" "GatewaySubnet_sec_group" {
#  subnet_id                 = azurerm_subnet.GatewaySubnet.id
#  network_security_group_id = azurerm_network_security_group.main.id
#}

