output "arn" {
  value       = aws_ecr_repository.ecr.arn
  description = "ARN of the container repo"
}

output "repository_url" {
  value       = aws_ecr_repository.ecr.repository_url
  description = "The URL of the repository"
}
