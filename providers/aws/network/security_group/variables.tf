variable "security_group" {
  type = list(object({
    security_group_name = string
    ingress = list(object({
      description = string
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    }))
  }))
}

variable "vpc_id" {
  type = string
}