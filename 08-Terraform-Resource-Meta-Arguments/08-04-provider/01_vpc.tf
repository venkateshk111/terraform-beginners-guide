 # Create VPC in different regions using different providers

# Create VPC in North-Virginia Region
resource "aws_vpc" "nv-vpc" {
  # meta argument provider is used to specify which provider to be used
  provider   = aws.us-east-nv
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "North-Virginia-VPC"
  }
}

# Create VPC in Mumbai Region
resource "aws_vpc" "mum-vpc" {
  # meta argument provider is used to specify which provider to be used
  provider   = aws.ap-south-mumbai
  cidr_block = "10.2.0.0/16"

  tags = {
    Name = "Mumbai-VPC"
  }
}