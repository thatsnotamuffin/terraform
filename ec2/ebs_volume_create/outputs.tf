output "ebs_volume_id" {
    description = "ID of the created EBS volume"
    value       = aws_ebs_volume.ebs_volume_create.id
}

