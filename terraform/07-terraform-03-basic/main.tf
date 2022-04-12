provider "aws" {
  region = "eu-central-1"
}

locals {
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners   = ["099720109477"]
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_instance" "es2_netology01" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.ubuntu.id
  count         = local.web_instance_count_map[terraform.workspace]
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name   = "netology"
    Lesson = "07-03"
  }
}

resource "aws_instance" "es2_netology02" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  for_each      = var.instances

  tags = {
    Name   = each.value.name
    Lesson = "07-03"
  }
}
