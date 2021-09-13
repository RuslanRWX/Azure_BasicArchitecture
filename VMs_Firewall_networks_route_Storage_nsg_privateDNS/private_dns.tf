resource "azurerm_private_dns_zone" "main_private_dns" {
  name                = "privatelink.ruslansvs.net"
  resource_group_name = azurerm_resource_group.terra-rg.name
}

#resource "azurerm_private_dns_zone_virtual_network_link" "main_endpoint_link1" {
#  name                  = "main_endpoint_link1"
##  resource_group_name = azurerm_resource_group.terra-rg.name
#  private_dns_zone_name = azurerm_private_dns_zone.main_private_dns.name
#  virtual_network_id    = azurerm_virtual_network.main.name
#}