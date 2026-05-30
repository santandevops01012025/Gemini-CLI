module "resource_group" {
  source = "../../modules/resource_group"

  resource_groups = var.resource_groups
}

module "network" {
  source = "../../modules/network"

  vnets = {
    for k, v in var.vnets : k => merge(v, {
      # Assuming we use the first resource group created for simplicity, 
      # or we could map them specifically. For this example, I'll match by name.
      resource_group_name = module.resource_group.resource_group_names["dev-rg"]
      location            = module.resource_group.resource_group_locations["dev-rg"]
    })
  }

  depends_on = [module.resource_group]
}

module "aks" {
  source = "../../modules/aks"

  aks_clusters = {
    for k, v in var.aks_clusters : k => merge(v, {
      resource_group_name = module.resource_group.resource_group_names["dev-rg"]
      location            = module.resource_group.resource_group_locations["dev-rg"]
      identity_type       = "SystemAssigned"
      
      default_node_pool = merge(v.default_node_pool, {
        vnet_subnet_id = module.network.subnet_ids["dev-vnet-aks-subnet"]
      })
    })
  }

  depends_on = [module.network]
}
