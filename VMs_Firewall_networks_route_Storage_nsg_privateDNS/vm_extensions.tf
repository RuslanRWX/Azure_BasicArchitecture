
resource "azurerm_virtual_machine_extension" "install_nginx" {
  for_each              = toset(local.vms)
  name                 = "${var.prefix}-nginx-extantion"
  virtual_machine_id   = azurerm_linux_virtual_machine.VM-TO[each.key].id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "commandToExecute": "yum install httpd -y >> /root/log"
    }
SETTINGS


  tags = {
    environment = "Production"
  }
}

      #  "fileUris": ["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"],
      #  "commandToExecute": "./configure-nginx.sh; echo run_script >> /root/log"