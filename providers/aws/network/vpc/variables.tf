variable "vpc_name" {
  type = string
  description = "Dar nome a vpc"
}

variable "cidr" {
  type = string
  default = "192.168.0.0/22"
  description = "Informar a mascara de rede"
}