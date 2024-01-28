data "aws_ami" "amzn_linux_2023_latest" {
    most_recent = true
    owners = [ "amazon" ]

    filter {
      name = "name"
      values = [ "al2023-ami-2023*" ]
    }

    filter {
      name = "architecture"
      values = [ "x86_64" ]
    }

    filter {
      name = "root-device-type"
      values = [ "ebs" ]
    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
}