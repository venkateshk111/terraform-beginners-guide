# Terraform Block (>0.13 version) or Terraform Settings Block or Terraform Configuration Block
# Use terraform block to define Required terraform version, Providers, terraform backend (state file)
terraform {
  required_version = "~> 0.14.3"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "my-tf-state-bucket"
    key    = "path/to/my/key"
  }  
}
