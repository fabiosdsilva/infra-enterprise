data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] #Ubuntu
}

resource "aws_instance" "web-servers" {
  count = length(var.ec2-web-servers)

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2-web-servers[count.index].instance_type
  key_name      = var.ec2-web-servers[count.index].key_name

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.ec2-web-servers[count.index].volume_size
    volume_type = var.ec2-web-servers[count.index].volume_type
  }

  tags = {
    Name = "${trimspace(var.ec2-web-servers[count.index].name)}"
  }

}