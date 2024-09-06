output "arn" {
  description = "ARN of the user"
  value       = aws_iam_user.user.arn
}

output "id" {
  description = "User's name"
  value       = aws_iam_user.user.id
}

output "name" {
  description = "User's name"
  value       = aws_iam_user.user.name
}

output "unique_id" {
  description = "The unique ID assigned by AWS"
  value       = aws_iam_user.user.unique_id
}
