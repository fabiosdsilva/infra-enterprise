variable "eip_nat_gateway" {
  type = object({
    name        = string
    eip_id      = string
    subnet_id   = string
  })
}