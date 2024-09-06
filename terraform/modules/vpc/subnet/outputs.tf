output "id" {
  description = "The ID of the subnet"
  value       = aws_subnet.subnet.id
}

output "arn" {
  description = "The ARN of the subnet"
  value       = aws_subnet.subnet.arn
}
