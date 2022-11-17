resource "aws_subnet" "public_subnet" {
  vpc_id     = var.public_subnet.vpc_id
  cidr_block = var.public_subnet.cidr

  tags = {
    Name = var.public_subnet.name
  }
}