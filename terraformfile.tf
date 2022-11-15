### Vpc
module "vpc" {
  source    = "./providers/aws/network/vpc"
  vpc_name  = "balsamo"
  cidr      = "192.168.0.0/22"
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