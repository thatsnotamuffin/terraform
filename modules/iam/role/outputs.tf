output "arn" {
  value       = aws_iam_role.role.arn
  description = "ARN specifying the role"
}

output "id" {
  value       = aws_iam_role.role.id
  description = "Name of the role"
}

output "name" {
  value       = aws_iam_role.role.name
  description = "Name of the role"
}
