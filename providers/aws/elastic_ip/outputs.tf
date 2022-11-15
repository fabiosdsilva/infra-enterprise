output "elastic_ip" {
  value = {
    for i, k in aws_eip.eip: i => k.id
  }
}