# Resource: aws_eip
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "my-web-ec2-eip" {
  instance   = aws_instance.my-web-ec2.id
  depends_on = [aws_instance.my-web-ec2]
}