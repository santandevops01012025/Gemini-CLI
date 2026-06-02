module "resource_group" {
  source = "../../modules/resource_group"

  resource_groups = var.resource_groups
}

locals {
  # Pick the first resource group as a default for resources that don't specify one
  default_rg_key = keys(var.resource_groups)[0]
}

module "network" {
  source = "../../modules/network"

  vnets = {
    for k, v in var.vnets : k => merge(v, {
      resource_group_name = module.resource_group.resource_group_names[local.default_rg_key]
      location            = module.resource_group.resource_group_locations[local.default_rg_key]
    })
  }

  depends_on = [module.resource_group]
}

module "aks" {
  source = "../../modules/aks"

  aks_clusters = {
    for k, v in var.aks_clusters : k => merge(v, {
      resource_group_name = module.resource_group.resource_group_names[local.default_rg_key]
      location            = module.resource_group.resource_group_locations[local.default_rg_key]
      identity_type       = "SystemAssigned"

      default_node_pool = merge(v.default_node_pool, {
        vnet_subnet_id = module.network.subnet_ids["santan-dev-vnet-santan-aks-subnet"]
      })
    })
  }

  depends_on = [module.network]
}
