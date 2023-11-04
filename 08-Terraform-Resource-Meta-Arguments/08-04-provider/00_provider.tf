terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Define First AWS Provider (us-east-1)
provider "aws" {
  region = "us-east-1"
  alias  = "us-east-nv"

  default_tags {
    tags = {
      Terraform = "yes"
      Region    = "N.Virginia"
    }
  }
}

# Defining Second AWS Provider (ap-south-1)
provider "aws" {
  region = "ap-south-1"
  alias  = "ap-south-mumbai"

  default_tags {
    tags = {
      Terraform = "yes"
      Region    = "Mumbai"
    }
  }
}