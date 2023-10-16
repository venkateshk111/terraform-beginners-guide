terraform {
  required_version = "~> 0.14.3"
  required_providers {
    aws = {
        version = "~> 2.7.0"
        source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "my-tf-state-bucket"
    key    = "path/to/my/key"
  }  
}