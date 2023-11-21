resource "aws_instance" "myec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  user_data     = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl enable httpd
  sudo systemctl start httpd
  echo "<html><body><div><h1><center> Good day! This AWS Infrastructure is Deployed via Terraform ! </center></h1></div></body></html>" | sudo tee /var/www/html/index
  EOF

  tags = {
    Name = "Linux2023"
  }
}