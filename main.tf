provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "malachi-terraform-backend"
    region = var.region
    //dynamodb_table = "terraform-lock"
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
}

output "ip" {
  value = aws_instance.ec2_instance.public_ip
}