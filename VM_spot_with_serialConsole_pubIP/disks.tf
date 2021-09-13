resource "azurerm_managed_disk" "vm01-disk01" {
  name                 = "vm01-disk01"
  location             = var.location
  resource_group_name  = var.resource
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm01-disk01" {
  managed_disk_id    = azurerm_managed_disk.vm01-disk01.id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = "10"
  caching            = "ReadWrite"
}
resource "azurerm_managed_disk" "vm01-disk02" {
  name                 = "vm01-disk02"
  location             = var.location
  resource_group_name  = var.resource
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm01-disk02" {
  managed_disk_id    = azurerm_managed_disk.vm01-disk02.id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = "9"
  caching            = "ReadWrite"
}


# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group      = var.resource
    }

    byte_length = 4
}

resource "azurerm_storage_account" "bootdiagnostics" {
  name                     = "bootdiagnostics${random_id.randomId.hex}"
  location                 = var.location
  resource_group_name      = var.resource
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
