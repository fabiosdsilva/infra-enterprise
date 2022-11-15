output "id_gateway" {
  value = aws_internet_gateway.gateway.id
}

output "gateway_name" {
  value = aws_internet_gateway.gateway.tags_all
}