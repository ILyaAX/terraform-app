terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.00"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "devops" {
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name = "AWS_ax"
  vpc_security_group_ids = [aws_security_group.all.id]
  count = 3
  
  tags = {
    Name = "devops"
  }
}

resource "aws_s3_object" "app" {
    bucket = "devopschool-webapp-bucket"
    key    = "hello-1.0.war"
    source = "aws_instance.build:/opt/target/hello-1.0.war"
}

resource "aws_security_group" "all" {
  name        = "all"
  description = "all"

  ingress {
      description      = "http"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name = "all"
  }
}

output "instance_public_ip" {
  description = "IP address devops"
  value       = aws_instance.devops.public_ip
}