output "ami_arn" {
  description = "ARN of the created AMI"
  value       = aws_ami_from_instance.create_ami
}

output "ami_id" {
  description = "ID of the created AMI"
  value       = aws_ami_from_instance.create_ami
}
