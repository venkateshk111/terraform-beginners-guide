# terraform {
#   backend "s3" {
#     bucket         = "tf-aws-backend"
#     key            = "tf/dev/terraform.tfstate"
#     region         = "us-east-1"
#     #dynamodb_table = "tf-dev-state-lock"
#   }
# }