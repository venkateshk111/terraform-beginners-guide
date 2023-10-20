resource "aws_vpc" "appvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "myapp-vpc"
      terraform = "true"
    }
}