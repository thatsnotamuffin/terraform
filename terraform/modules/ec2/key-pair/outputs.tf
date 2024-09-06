output "id" {
  description = "The key pair name"
  value       = aws_key_pair.key_pair.id
}

output "arn" {
  description = "ARN of the key pair"
  value       = aws_key_pair.key_pair.arn
}

output "key_name" {
  description = "The key pair name"
  value       = aws_key_pair.key_pair.key_name
}

output "key_pair_id" {
  description = "The key pair ID"
  value       = aws_key_pair.key_pair.key_pair_id
}

output "key_type" {
  description = "The type of key pair"
  value       = aws_key_pair.key_pair.key_type
}
