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