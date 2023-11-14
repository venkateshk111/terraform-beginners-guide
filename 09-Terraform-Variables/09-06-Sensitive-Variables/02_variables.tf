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

variable "db_username" {
  description = "DB User Name"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "DB Password"
  type        = string
  sensitive   = true
}