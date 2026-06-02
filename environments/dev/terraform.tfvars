resource_groups = {
  "santan-dev-rg-99" = {
    location = "East US"
    tags = {
      environment = "dev"
      owner       = "team-alpha"
    }
  }
}

vnets = {
  "santan-dev-vnet" = {
    address_space = ["10.0.0.0/16"]
    subnets = {
      "santan-aks-subnet" = {
        address_prefixes = ["10.0.1.0/24"]
      }
    }
    tags = {
      environment = "dev"
    }
  }
}

aks_clusters = {
  "santan-dev-aks" = {
    dns_prefix = "santandevaks"
    default_node_pool = {
      name       = "santanpool"
      node_count = 2
      vm_size    = "Standard_DC2as_v5"
    }
    network_profile = {
      network_plugin     = "azure"
      network_policy     = "azure"
      service_cidr       = "172.16.0.0/16"
      dns_service_ip     = "172.16.0.10"
    }
    tags = {
      environment = "dev"
    }
  }
}
