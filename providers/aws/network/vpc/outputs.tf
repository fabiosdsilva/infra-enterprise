output "id_vpc" {
  value = aws_vpc.vpc-lab.id
  description = "Exibe o id da vpc criada"
}

output "vpc_name" {
  value = aws_vpc.vpc-lab.tags_all
}