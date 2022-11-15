resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.network_gateway_name
  }
}