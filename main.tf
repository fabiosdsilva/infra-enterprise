provider "aws" {
  region = terraform.workspace == "production" ? "us-east-1" : "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "infra-enterprise" ## Colocar o nome do bucket
    key     = "terraform.state"
    region  = "us-east-1"
    encrypt = true
  }
}