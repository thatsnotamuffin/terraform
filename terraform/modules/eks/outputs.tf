output "cluster_arn" {
  description = "ARN of the EKS Cluster"
  value       = module.eks.arn
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS API server"
  value       = module.eks.endpoint
}
