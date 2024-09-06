# Security Group
output "arn" {
  description = "ARN of the security group"
  value       = aws_security_group.security_group.arn
}

output "id" {
  description = "ID of the security group"
  value       = aws_security_group.security_group.id
}
