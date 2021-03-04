  variable "image_id" {
    type = string
  }
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = var.image_id
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}

