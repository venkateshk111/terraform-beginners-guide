variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "owner" {
  type    = string
  default = "Venkatesh"
}

variable "ec2_ami" {
  type    = string
  default = "ami-0df435f331839b2d6" # Amazon Linux 2023
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}
