
/*
resource "azurerm_firewall" "FW_MAIN" {
  name                = "FW_MAIN"
  location            = azurerm_resource_group.terra-rg.location
resource_group_name   = azurerm_resource_group.terra-rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.FireWall.id
  }
}

resource "azurerm_firewall_network_rule_collection" "Deny_All" {
  name                = "Deny_All"
  azure_firewall_name = azurerm_firewall.FW_MAIN.name
  resource_group_name = azurerm_resource_group.terra-rg.name
  priority            = 5000
  action              = "Deny"

  rule {
    name = "rule"

    source_addresses = [
      "*"
    ]

    destination_ports = [
      "*"
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "TCP",
      "UDP"
    ]
  }
}

resource "azurerm_firewall_network_rule_collection" "rule_allow_local" {
  name                = "rule_allow_ssh"
  azure_firewall_name = azurerm_firewall.FW_MAIN.name
  resource_group_name = azurerm_resource_group.terra-rg.name
  priority            = 1000
  action              = "Allow"

  rule {
    name = "rule"

    source_addresses = [
      "*"
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "TCP"
    ]
  }
}

resource "azurerm_firewall_network_rule_collection" "egress_allow" {
  name                = "egress_allow"
  azure_firewall_name = azurerm_firewall.FW_MAIN.name
  resource_group_name = azurerm_resource_group.terra-rg.name
  priority            = 2100
  action              = "Allow"

  rule {
    name = "rule"

    source_addresses = [
      "10.84.1.0/24"
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "TCP",
      "UDP"
    ]
  }
}
*/
/*
resource "azurerm_firewall_nat_rule_collection" "ingress_allow_22" {
  name                = "ingress_allow_22"
  azure_firewall_name = azurerm_firewall.FW_MAIN.name
  resource_group_name = azurerm_resource_group.terra-rg.name
  priority            = 1100
  action              = "Dnat"

  rule {
    name = "rule ssh pass"

    source_addresses =  flatten([
      "*"
    ])
    destination_ports =  flatten([
      "22022"
    ])
    destination_addresses =  flatten([ 
      "52.142.25.252"
    ])
    translated_port = "22"
  
    translated_address = "10.84.1.100"
    
    protocols = [
      "TCP"
]
  }
}
*/
/*
# nat
resource "azurerm_firewall_nat_rule_collection" "Snat53" {
  name                = "Snat53"
  azure_firewall_name = azurerm_firewall.FW_MAIN.name
  resource_group_name = azurerm_resource_group.terra-rg.name
  priority            = 200
  action              = "Snat"

  rule {
    name = "snat53"

    source_addresses = [
      "10.84.1.0/24",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "*"
    ]

    translated_port = 53

    translated_address = "8.8.8.8"

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}
*/
/*
resource "azurerm_firewall_nat_rule_collection" "Dnat22" {
  name                = "Dnat22"
  azure_firewall_name = azurerm_firewall.FW_MAIN.name
  resource_group_name = azurerm_resource_group.terra-rg.name
  priority            = 220
  action              = "Dnat"

  rule {
    name = "rule_pass_22"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      azurerm_public_ip.FireWall.id
    ]

    translated_port = 22

    translated_address = "10.84.1.100"

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}
*/


