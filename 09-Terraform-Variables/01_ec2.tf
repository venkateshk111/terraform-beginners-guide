resource "aws_instance" "myec2" {
  # terraform arguments without variables
  # ami = "ami-0df435f331839b2d6"
  # instance_type = "t2.micro"
  # count = 1

  # using variables for arguments
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  count         = var.instance_count

  tags = {
    Name = "Linux2023"
  }
}