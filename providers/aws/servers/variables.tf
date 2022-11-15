variable "ec2-web-servers" {
  description = "Nome das instancias Ec2"
  type = list(object({
    name          = string
    instance_type = string
    key_name      = string
    volume_size   = number
    volume_type   = string
  }))
}