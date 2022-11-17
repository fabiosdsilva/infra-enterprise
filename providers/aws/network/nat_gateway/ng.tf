
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.eip_nat_gateway.eip_id
  subnet_id     = var.eip_nat_gateway.subnet_id

  tags = {
    Name = var.eip_nat_gateway.name
  }
}