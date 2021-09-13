/*
resource "azurerm_linux_virtual_machine" "VM-TO-vm02" {
  name                  = "VM-T0-vm02"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  size                            = "Standard_B2ms"
  admin_username                  = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.VM-TO-nic-vm02.id,
  ]

  admin_ssh_key {
    username = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  tags = {
    environment = "Test rettaform"
  }
}

### VMs   interface 
resource "azurerm_network_interface" "VM-TO-nic-vm02" {
  name                = "${var.prefix}-VM-TO-now-nic-vm02"
  location            = azurerm_resource_group.terra-rg.location
  resource_group_name = azurerm_resource_group.terra-rg.name

  ip_configuration {
    name                          = "${var.prefix}-configuration1VM-T0-vm02"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm02.id
  }
}

resource "azurerm_public_ip" "vm02" {
    name                         = "${var.prefix}-PublicIP-new-vm02"
    location                     = azurerm_resource_group.terra-rg.location
    resource_group_name          = azurerm_resource_group.terra-rg.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo",
        IP_type = "new-vm02"
    }
}
*/
/*
resource "azurerm_managed_disk" "vm02-disk" {
  name                 = "disk0"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1023
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm02-disk" {
  managed_disk_id    = azurerm_managed_disk.vm02-disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.VM-TO-vm02.id
  lun                = "0"
  caching            = "ReadOnly"
  depends_on         = [azurerm_managed_disk.vm02-disk]
}

*/