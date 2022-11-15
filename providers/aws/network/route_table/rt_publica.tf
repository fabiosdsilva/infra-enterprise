
resource "aws_route_table" "rt_public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.cidr_block_rt_public
    gateway_id = var.gateway_id
  }
  tags = {
    Name = var.rt_public_name
  }
}