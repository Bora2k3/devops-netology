terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  #connect
  backend "s3" {
    bucket = "bora2k3"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform_state"
  }
}
