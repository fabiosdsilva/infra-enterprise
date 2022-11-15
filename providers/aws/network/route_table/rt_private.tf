resource "aws_route_table" "rt_private" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.cidr_block_rt_private
    nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    Name = var.rt_private_name
  }
}