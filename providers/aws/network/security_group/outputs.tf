output "security_groups" {
  value = {
    for k, identifier in aws_security_group.developer: k => identifier.id
  }
}