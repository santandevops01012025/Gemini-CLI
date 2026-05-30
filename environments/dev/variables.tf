variable "resource_groups" {
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
}

variable "vnets" {
  type = map(object({
    address_space = list(string)
    subnets = map(object({
      address_prefixes = list(string)
    }))
    tags = optional(map(string), {})
  }))
}

variable "aks_clusters" {
  type = map(object({
    dns_prefix = string
    default_node_pool = object({
      name       = string
      node_count = number
      vm_size    = string
    })
    network_profile = optional(object({
      network_plugin = string
      network_policy = optional(string)
    }))
    tags = optional(map(string), {})
  }))
}
