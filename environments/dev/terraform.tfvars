resource_groups = {
  "santan-new-dev-rg" = {
    location = "East US"
    tags = {
      environment = "dev"
      owner       = "team-alpha"
    }
  }
}

vnets = {
  "santandev-vnet" = {
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
  "santandev-aks" = {
    dns_prefix = "devaks"
    default_node_pool = {
      name       = "default"
      node_count = 2
      vm_size    = "Standard_DC2as_v5"
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
