# all VMs

/* LOOP 
resource "azurerm_virtual_machine" "main" {
  for_each              = toset(local.vms)
#  count                 = 2
  name                  = "${var.prefix}-vm-${each.key}"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  network_interface_ids = [azurerm_network_interface.main[each.key].id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1-${each.key}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname-${each.key}"
    admin_username = "adminuser"
    admin_password = "Rubuntu0019!@"
    custom_data    = "${file("cloud-init.sh")}" # file("could-init.sh")
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Test rettaform"
  }
}
resource "azurerm_network_interface" "main" {
  for_each              = toset(local.vms)
  name                = "${var.prefix}-nic-${each.key}"
  location            = azurerm_resource_group.terra-rg.location
  resource_group_name = azurerm_resource_group.terra-rg.name

  ip_configuration {
    name                          = "${var.prefix}-configuration1"
    subnet_id                     = azurerm_subnet.common.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.loop[each.key].id
  }
}
#*/

#*/  # LOOP END

#/* LOOP LINUX 

#/*   test last
resource "azurerm_linux_virtual_machine" "VM-TO" {
  for_each              = toset(local.vms)
  name                  = "VM-T0-${each.key}"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  size                            = "Standard_B2ms"
  admin_username                  = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.VM-TO-nic[each.key].id,
  ]
   custom_data    = base64encode(file("cloud-init.sh")) # file("could-init.sh")

  admin_ssh_key {
    username = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    #publisher = "Canonical"
    #offer     = "UbuntuServer"
    #sku       = "18.04-LTS"
    #version   = "latest"
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7-LVM"
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
resource "azurerm_network_interface" "VM-TO-nic" {
  for_each            = toset(local.vms)
  name                = "${var.prefix}-VM-TO-nic-${each.key}"
  location            = azurerm_resource_group.terra-rg.location
  resource_group_name = azurerm_resource_group.terra-rg.name

  ip_configuration {
    name                          = "${var.prefix}-configuration1VM-T0-${each.key}"
    subnet_id                     = azurerm_subnet.common.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.loop[each.key].id
  }
}

#*/ LOOP VMs 


/* # ONE VM VM-T0

resource "azurerm_linux_virtual_machine" "VM-TO" {
  name                  = "VM-T0"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  size                            = "Standard_B2ms"
  admin_username                  = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.VM-TO-nic.id,
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


### VM VM-T0  interface 
resource "azurerm_network_interface" "VM-TO-nic" {
  name                = "${var.prefix}-VM-TO-nic"
  location            = azurerm_resource_group.terra-rg.location
  resource_group_name = azurerm_resource_group.terra-rg.name

  ip_configuration {
    name                          = "${var.prefix}-configuration1VM-T0"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}
*/ #One VM

/*
resource "azurerm_managed_disk" "VM-TO-DISK0" {
  name                 = "disk0"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}

resource "azurerm_virtual_machine_data_disk_attachment" "VM-TO-DISK0" {
  managed_disk_id    = azurerm_managed_disk.VM-TO-DISK0.id
  virtual_machine_id = azurerm_linux_virtual_machine.VM-TO.id
  lun                = "1"
  caching            = "ReadOnly"
  depends_on         = [azurerm_managed_disk.VM-TO-DISK0]
}
*/ #One VM #

/*
resource "azurerm_managed_disk" "data" {
  name                 = "disk0"
  location              = azurerm_resource_group.terra-rg.location
  resource_group_name   = azurerm_resource_group.terra-rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1023
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  managed_disk_id    = azurerm_managed_disk.data.id
  virtual_machine_id = azurerm_virtual_machine.main.[each.key]
  lun                = "0"
  caching            = "ReadOnly"
  depends_on         = [azurerm_managed_disk.data]
}*/
/*

output "virtual_machine_id" {
  value = azurerm_virtual_machine.main.${each.key}
}
*/
