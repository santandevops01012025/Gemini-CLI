resource_groups = {
  "dev-rg" = {
    location = "East US"
    tags = {
      environment = "dev"
      owner       = "team-alpha"
    }
  }
}

vnets = {
  "dev-vnet" = {
    address_space = ["10.0.0.0/16"]
    subnets = {
      "aks-subnet" = {
        address_prefixes = ["10.0.1.0/24"]
      }
    }
    tags = {
      environment = "dev"
    }
  }
}

aks_clusters = {
  "dev-aks" = {
    dns_prefix = "devaks"
    default_node_pool = {
      name       = "default"
      node_count = 2
      vm_size    = "Standard_DS2_v2"
    }
    network_profile = {
      network_plugin = "azure"
      network_policy = "azure"
    }
    tags = {
      environment = "dev"
    }
  }
}
