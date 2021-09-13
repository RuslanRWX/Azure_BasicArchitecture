/*
resource "azurerm_automation_account" "main_dsc_accout" {
  name                = "${var.prefix}-main-dsc"
  location            = azurerm_resource_group.terra-rg.location
  resource_group_name = azurerm_resource_group.terra-rg.name
  sku_name = "Basic"
}

resource "azurerm_automation_dsc_configuration" "add_file" {
  name                    = "add_file2"
  resource_group_name     = azurerm_resource_group.terra-rg.name
  automation_account_name = azurerm_automation_account.main_dsc_accout.name
  location                = azurerm_resource_group.terra-rg.location
  content_embedded        = <<dsccontent
configuration add_file2 {
Import-DSCResource -Module nx

Node $node
{
    nxScript KeepDirEmpty {

GetScript = @"
#!/bin/bash
ls /tmp/test.file | wc -l
"@


SetScript = @"
#!/bin/bash
touch /tmp/test.file
"@

TestScript = @'
#!/bin/bash
filecount=`ls /tmp/test.file | wc -l`
if [ $filecount -gt 0 ]
then
    exit 1
else
    exit 0
fi
'@
    }
}
}
dsccontent

}
*/
