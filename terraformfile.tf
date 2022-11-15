### Vpc
module "vpc" {
  source    = "./providers/aws/network/vpc"
  vpc_name  = "balsamo"
  cidr      = "192.168.0.0/22"
}

## Internet gateway
module "network_gateway" {
  source                = "./providers/aws/network/internet_gateway"
  network_gateway_name  = "internet-gateway-publica"
  vpc_id                = module.vpc.id_vpc
  depends_on            = [module.vpc]
}

## Key pairs
module "key_pairs" {
  source = "./providers/aws/key_pairs"

  key_name = [
    "key-balsamo-server"
  ]
}

## Ec2
module "ec2" {
  source = "./providers/aws/ec2"

#   ec2-web-servers = [
#     {
#       name          = ""
#       instance_type = ""
#       key_name      = ""
#       volume_size   = 8
#       volume_type   = ""
#     }
#   ]

  depends_on = [
    module.key_pairs
  ]
}

## Outputs
output "public_ip" {
  value = module.ec2.instance_address
}