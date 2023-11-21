output "myec2_public_ip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.myec2.public_ip
}

output "myec2_private_ip" {
  description = "EC2 Instance Private IP"
  value       = aws_instance.myec2.private_ip
}

output "myec2_tags" {
  description = "EC2 Instance Tags"
  value       = aws_instance.myec2.tags_all
}

output "myec2_public_dns" {
  description = "Public DNS"
  value       = "http://${aws_instance.myec2.public_dns}"
}