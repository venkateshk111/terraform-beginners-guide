resource "aws_instance" "myec2" {
  ami = data.aws_ami.amzn_linux_2023_latest.id # fetching Latest Amazon Linux AMI id from data sources
  instance_type = var.ec2_instance_type

  tags = {
    Name = "Linux2023"
  }
}