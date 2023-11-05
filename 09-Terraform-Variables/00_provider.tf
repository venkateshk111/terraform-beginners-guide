terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  #region = "us-east-1"
  region = var.aws_region

  default_tags {
    tags = {
      Terraform = "yes"
      #Owner = "Venkatesh"
      Owner = var.owner
    }
  }
}