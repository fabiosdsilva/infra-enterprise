output "security_groups" {
  value = {
    for k, identifier in aws_security_group.main: k => identifier.id
  }
}