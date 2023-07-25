terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
  }
}


provider "aws" {
  region = var.AWS_REGION
}

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "default vpc"
  }
}

resource "aws_security_group" "mc_jenkins_ec2_secgrp" {
  name        = "mc_jenkins_ec2_secgrp"
  description = "Allow ssh + http traffic "
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http proxy access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http secure traffic access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mc jenkins server security group"
  }
}

resource "aws_instance" "jenkins_ec2" {
  ami                    = var.AMI
  instance_type          = var.INSTANCE_TYPE
  vpc_security_group_ids = [aws_security_group.mc_jenkins_ec2_secgrp.id]
  key_name               = var.AWS_KEY_PAIR
  user_data              = file("install_jenkins.sh")

  tags = {
    Name = "MC-Jenkins-EC2"
  }
}

output "jenkins_url" {
  value = join("", ["http://", aws_instance.jenkins_ec2.public_ip, ":", "8080"])
}