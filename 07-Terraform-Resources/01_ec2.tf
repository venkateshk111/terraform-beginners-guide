resource "aws_ec2" "example" {
  ami           = "ami-0df435f331839b2d6"
  instance_type = "t2.micro"

  tags = {
    Name = "Linux2023"
    Owner = "Venkatesh"
  }
}


