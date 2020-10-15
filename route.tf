

resource "azurerm_route_table" "main_route" {
  name                          = "acceptanceTestSecurityGroup1"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  disable_bgp_route_propagation = false
}
/*
  route {
    name           = "to_main_firewall"
    address_prefix = "0.0.0.0/0"
    #next_hop_type  = "vnetlocal"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.84.1.4"

  }

  tags = {
    environment = "Production"
  }
}
*/


resource "azurerm_route" "AZ_to_FW" {
  name                   = "AZ_to_FW"
  resource_group_name   = azurerm_resource_group.terra-rg.name
  route_table_name       = azurerm_route_table.main_route.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.84.1.4" 

  depends_on = [azurerm_route_table.main_route]
}

resource "azurerm_route" "AZ_to_Net" {
  name                   = "AZ_to_Net"
  resource_group_name   = azurerm_resource_group.terra-rg.name
  route_table_name       = azurerm_route_table.main_route.name
  address_prefix         = "10.84.1.0/26"
#  next_hop_type       = "VnetLocal"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.84.1.4"
  depends_on = [azurerm_route_table.main_route]
}


resource "azurerm_subnet_route_table_association" "common-to-route-table" {
  subnet_id      = azurerm_subnet.common.id
  route_table_id = azurerm_route_table.main_route.id
}

/*
resource "azurerm_subnet_route_table_association" "azurefirewallsubnet-to-route-table" {
  subnet_id      = azurerm_subnet.AzureFirewallSubnet.id
  route_table_id = azurerm_route_table.main_route.id
}
resource "azurerm_subnet_route_table_association" "gatewaysubnet-to-route-table" {
  subnet_id      = azurerm_subnet.GatewaySubnet.id
  route_table_id = azurerm_route_table.main_route.id
}
*/
