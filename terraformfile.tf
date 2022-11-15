### Vpc
module "vpc" {
  source    = "./providers/aws/network/vpc"
  vpc_name  = "balsamo"
  cidr      = "192.168.0.0/22"
}

## Internet gateway
module "internet_gateway" {
  source                = "./providers/aws/network/internet_gateway"
  internet_gateway_name  = "internet-gateway-publica"
  vpc_id                = module.vpc.id_vpc
  depends_on            = [module.vpc]
}

## Nat gateway
module "nat_gateway" {
  source          = "./terraform-aws-modules/nat_gateway"
  eip_nat_gateway = {
    name      = "nat-gateway"
    eip_id    = module.eip.id_eip_nat
    subnet_id = module.subnet.public_subnet
  }

  depends_on = [
    module.internet_gateway,
    module.subnet,
    module.vpc,
    module.eip
  ]
}

## Route table
module "route_table" {
  source                = "./providers/aws/network/route_table"
  vpc_id                = module.vpc.id_vpc
  cidr_block_rt_public  = "0.0.0.0/0"
  cidr_block_rt_private = "0.0.0.0/0"
  rt_public_name        = "public_rt"
  rt_private_name       = "private_rt"
  gateway_id            = module.internet_gateway.id_gateway
  nat_gateway_id        = module.nat_gateway.id_nat_gateway
  depends_on            = [
    module.vpc,
    module.internet_gateway,
    module.subnet,
    module.nat_gateway
  ]
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