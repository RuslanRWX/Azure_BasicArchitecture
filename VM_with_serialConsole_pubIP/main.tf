provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
#  version         = ">= 14.0"
  features {}

}

resource "azurerm_resource_group" "kloomba-rg" {
  name     = var.resource
  location = var.location
}


resource "azurerm_public_ip" "main" {
    name                         = "PublicIP"
    location                     = var.location
    resource_group_name          = var.resource
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = var.resource
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "external" {
  name                 = "external"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = var.resource
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = var.resource
  location            = var.location


  ip_configuration {
    name                          = "primary"
    subnet_id                     =  azurerm_subnet.external.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = var.resource
  location                        = var.location
  size                            = "Standard_A2_v2"
  admin_username                  = "adminuser"

  priority = "Spot"
  eviction_policy = "Deallocate"

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

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

  boot_diagnostics {
  storage_account_uri = azurerm_storage_account.bootdiagnostics.primary_blob_endpoint
 }

}



