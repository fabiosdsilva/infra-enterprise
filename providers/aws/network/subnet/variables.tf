variable "public_subnet" {
  type  = object({
    name    = string
    vpc_id  = string
    cidr    = string
    azs     = list(string)
  })
}

variable "private_subnet" {
  type  = object({
    name    = string
    vpc_id  = string
    cidr    = string
    azs     = list(string)
  })
}