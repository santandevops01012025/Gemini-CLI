resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets

  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
  tags                = each.value.tags
}

locals {
  # Flatten subnets for for_each
  subnets = merge([
    for vnet_key, vnet_val in var.vnets : {
      for subnet_key, subnet_val in vnet_val.subnets :
      "${vnet_key}-${subnet_key}" => {
        vnet_key         = vnet_key
        subnet_name      = subnet_key
        address_prefixes = subnet_val.address_prefixes
        rg_name          = vnet_val.resource_group_name
      }
    }
  ]...)
}

resource "azurerm_subnet" "subnet" {
  for_each = local.subnets

  name                 = each.value.subnet_name
  resource_group_name  = each.value.rg_name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
}
