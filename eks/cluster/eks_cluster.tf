resource "aws_eks_cluster" "eks_cluster" {
    name        = var.cluster_name
    version     = var.version
    role_arn    = var.cluster_role

    vpc_config {
        subnet_ids              = var.subnet_ids
        endpoint_public_access  = var.public_access
        endpoint_private_access = var.private_access
        security_group_ids      = var.security_group_ids
    }

    enabled_cluster_log_types   = var.cluster_log_types

    tags = {
        Name    = var.cluster_name
        Region  = var.target_region
        Env     = var.target_env
        App     = var.target_app
        Service = var.target_service
    }
}
