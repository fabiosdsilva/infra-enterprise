resource "aws_subnet" "private_subnet" {
  vpc_id     = var.private_subnet.vpc_id
  cidr_block = var.private_subnet.cidr

  tags = {
    Name = var.private_subnet.name
  }
}