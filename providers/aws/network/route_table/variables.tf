variable "rt_public_name" {
  type        = string
  description = "Informar nome da tabela de roteamento"
}

variable "rt_private_name" {
  type        = string
  description = "Informar nome da tabela de roteamento"
}
variable "vpc_id" {
  type        = string
  description = "Id da vpc onde o grupo de segurança será criado"
}

variable "cidr_block_rt_public" {
  type        = string
  description = "Informar mascara de rede"
}

variable "cidr_block_rt_private" {
  type        = string
  description = "Informar mascara de rede"
}

variable "gateway_id" {
  type        = string
  description = "Informar o id do Gateway de internet"
}

variable "nat_gateway_id" {
  type        = string
  description = "Informar o Nat para a tabela de roteamente privada"
}