variable "vnets" {
  description = "A map of VNets and their subnets"
  type = map(object({
    resource_group_name = string
    location            = string
    address_space       = list(string)
    subnets = map(object({
      address_prefixes = list(string)
    }))
    tags = optional(map(string), {})
  }))
}
