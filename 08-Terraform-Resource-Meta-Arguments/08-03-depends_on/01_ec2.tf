resource "aws_instance" "my-web-ec2" {
  ami           = "ami-0df435f331839b2d6"
  instance_type = "t2.micro"

  tags = {
    Name  = "linux-webserver"
    Owner = "Venkatesh"
  }
}