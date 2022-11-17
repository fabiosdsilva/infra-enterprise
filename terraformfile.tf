## Vpc
module "vpc" {
  source    = "./providers/aws/network/vpc"
  vpc_name  = "balsamo"
  cidr      = "192.168.0.0/22"
}

## Elastic ip
module "eip" {
  source = "/providers/aws/network/elastic_ip"
  amount = 1
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
  source          = "./providers/aws/network/nat_gateway"
  eip_nat_gateway = {
    name      = "nat-gateway"
    eip_id    = module.eip.elastic_ip[0]
    subnet_id = module.subnet.public_subnet
  }

  depends_on = [
    module.internet_gateway,
    module.subnet,
    module.vpc,
    module.eip
  ]
}

## Subnet
module "subnet" {
  source        = "./terraform-aws-modules/subnet"
  public_subnet = {
    name      = "subnet-public-1a"
    vpc_id    = module.vpc.id_vpc
    cidr      = "192.168.1.0/24"
    azs       = ["${terraform.workspace == "production" ? "us-east-1a" : "us-west-2a"}"]
  }
  private_subnet = {
    name      = "subnet-private-1b"
    vpc_id    = module.vpc.id_vpc
    cidr      = "192.168.2.0/24"
    azs       = ["${terraform.workspace == "production" ? "us-east-1b" : "us-west-2b"}"]
  }
  
  depends_on = [module.vpc, module.internet_gateway]
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

## Route table association
module "rt_association" {
  source            = "./terraform-aws-modules/route_table_association"
  association_rt_public = {
    gateway_id      = module.network_gateway.id_gateway
    subnet_id       = module.subnet.public_subnet
    route_table_id  = module.route_table.id_rt_public
  }
  association_rt_private = {
    subnet_id       = module.subnet.private_subnet
    route_table_id  = module.route_table.id_rt_private
  }

  depends_on = [
    module.vpc,
    module.internet_gateway,
    module.subnet,
    module.route_table
  ]
}

## Security group
module "security_group" {
  source = "/providers/aws/network/security_group"
  security_group = [
    {
      security_group_name = "servers"
      ingress             = [
        {
          description = "SSH"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["45.168.89.213/0"]
        }
      ]
    }
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