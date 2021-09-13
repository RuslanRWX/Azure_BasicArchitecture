resource "azurerm_storage_account" "main_storage" {
  name                = "mainstorageruslansvs"
  resource_group_name = azurerm_resource_group.terra-rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location              = azurerm_resource_group.terra-rg.location
}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.main_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "main_blob_b1" {
  name                   = "cloud-init.sh"
  storage_account_name  = azurerm_storage_account.main_storage.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "cloud-init.sh"
}

####
####
#resource "azurerm_private_endpoint" "endpoint_main_container_p1" {
#  name                = "endpoint_main_p1"
#  location            = azurerm_resource_group.terra-rg.location
#  resource_group_name = azurerm_resource_group.terra-rg.name
##  subnet_id           = azurerm_subnet.common.id
 # type                   = "Block"
#
#
# private_service_connection {
#    name                            = "privat-endpoint-pe02"
#    private_connection_resource_id  = "/subscriptions/1a016607-e36e-4297-b485-caad3956d597/resourceGroups/Terra-RG/providers/Microsoft.Storage/storageAccounts/mainstorageruslansvs"
#    subresource_names               = ["blob"]
#    is_manual_connection            = true
#    request_message                 = "Request from Gjensidige to Second Floor file access"
#  }
#}