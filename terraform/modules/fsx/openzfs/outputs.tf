output "arn" {
  description = "ARN of the File System"
  value       = aws_fsx_openzfs_file_system.openzfs.arn
}

output "dns_name" {
  description = "DNS name for the file system"
  value       = aws_fsx_openzfs_file_system.openzfs.dns_name
}

output "endpoint_ip_address" {
  description = "IP address of the endpoint that is used to access the file system"
  value       = aws_fsx_openzfs_file_system.openzfs.endpoint_ip_address
}

output "id" {
  description = "ID of the file system"
  value       = aws_fsx_openzfs_file_system.openzfs.id
}

output "network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible The first network interface returned is the primary network interface"
  value       = aws_fsx_openzfs_file_system.openzfs.network_interface_ids
}
