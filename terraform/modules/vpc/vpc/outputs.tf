output "id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "arn" {
  description = "ARN of the VPC"
  value       = aws_vpc.vpc.arn
}
