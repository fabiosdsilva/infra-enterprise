resource "aws_vpc" "vpc-lab" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}