resource "aws_eip" "eip" {
  count = var.amount
  
  vpc = true
}