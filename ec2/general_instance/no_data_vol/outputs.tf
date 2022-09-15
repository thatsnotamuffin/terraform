# Server Arn
output "ec2_instance_id" {
    description = "ID of the created EBS volume"
    value       = aws_instance.ec2_server.id
}

