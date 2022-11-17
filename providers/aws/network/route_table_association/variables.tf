variable "association_rt_public" {
  type = object({
    gateway_id     = string
    subnet_id      = string
    route_table_id = string
  })
}

variable "association_rt_private" {
  type = object({
    subnet_id      = string
    route_table_id = string
  })
}