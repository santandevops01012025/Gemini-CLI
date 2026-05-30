variable "aks_clusters" {
  description = "A map of AKS clusters to create"
  type = map(object({
    resource_group_name = string
    location            = string
    dns_prefix          = string
    kubernetes_version  = optional(string)

    default_node_pool = object({
      name           = string
      node_count     = number
      vm_size        = string
      vnet_subnet_id = optional(string)
    })

    network_profile = optional(object({
      network_plugin = string
      network_policy = optional(string)
    }))

    identity_type = string # e.g., "SystemAssigned"

    tags = optional(map(string), {})
  }))
}
