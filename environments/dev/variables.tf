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
      network_plugin     = string
      network_policy     = optional(string)
      service_cidr       = optional(string)
      dns_service_ip     = optional(string)
      docker_bridge_cidr = optional(string)
    }))
    tags = optional(map(string), {})
  }))

  validation {
    condition = alltrue([
      for cluster in var.aks_clusters :
      length(cluster.default_node_pool.name) >= 1 &&
      length(cluster.default_node_pool.name) <= 12 &&
      can(regex("^[a-z][0-9a-z]*$", cluster.default_node_pool.name))
    ])
    error_message = "The default_node_pool.name must begin with a lowercase letter, contain only lowercase letters and numbers and be between 1 and 12 characters in length."
  }
}
