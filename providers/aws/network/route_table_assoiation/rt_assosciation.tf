resource "aws_route_table_association" "rt_public_subnet" {
    subnet_id      = var.association_rt_public["subnet_id"]
    route_table_id = var.association_rt_public["route_table_id"]
}

resource "aws_route_table_association" "rt_private" {
    subnet_id      = var.association_rt_private["subnet_id"]
    route_table_id = var.association_rt_private["route_table_id"]
}