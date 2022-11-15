output "instance_address" {
    value = {
        for i, k in aws_instance.web-servers: i => k.public_ip
    }
}

output "instance_address_dns" {
    value = {
        for i, k in aws_instance.web-servers: i => k.public_dns
    }
}