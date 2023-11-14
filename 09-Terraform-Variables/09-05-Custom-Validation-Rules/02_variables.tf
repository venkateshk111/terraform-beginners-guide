variable "aws_region" {
  description = "AWS Region In Which Resources will be Created"
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Name of the Engineer who is creating Resources"
  type        = string
  default     = "Venkatesh"
}

variable "ec2_ami" {
  description = "AWS EC2 AMI Amazon Linux 2023"
  type        = string
  #default     = "ami-0df435f331839b2d6" # Amazon Linux 2023
  default = "xyz-0df435f331839b2d6"
  validation {
    condition     = length(var.ec2_ami) > 4 && substr(var.ec2_ami, 0, 4) == "ami-"
    error_message = "The EC2 AMI ID value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "env" {
  description = "Environment Type"
  type        = string
  default     = "dev"
}
