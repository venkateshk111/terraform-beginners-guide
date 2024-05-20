resource "aws_instance" "amzlinux" {
  ami           = data.aws_ami.amzn_linux_2023_latest.id # fetching Latest Amazon Linux AMI id from data sources
  instance_type = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm.name

  tags = {
    Name = "Linux2023"
  }
}

resource "aws_instance" "windows2022" {
  ami           = data.aws_ami.windows_server_2022_latest.id # fetching Latest Windows 2022 AMI id from data sources
  instance_type = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm.name


  tags = {
    Name = "Winows2022"
  }
}