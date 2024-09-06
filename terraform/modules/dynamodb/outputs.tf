output "arn" {
  description = "ARN of the table"
  value       = aws_dynamodb_table.dynamodb_table.arn
}

output "id" {
  description = "Name of the table"
  value       = aws_dynamodb_table.dynamodb_table.id
}
