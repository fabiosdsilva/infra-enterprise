output "id_gateway" {
  value = aws_internet_gateway.ig.id
}

output "gateway_name" {
  value = aws_internet_gateway.ig.tags_all
}