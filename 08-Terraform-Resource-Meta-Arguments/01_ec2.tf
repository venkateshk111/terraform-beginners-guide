resource "aws_instance" "example" {
  count         = 2 # Using Meta argument to create 2 identical EC2 Instances
  ami           = "ami-0df435f331839b2d6"
  instance_type = "t2.micro"
}