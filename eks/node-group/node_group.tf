resource "aws_eks_node_group" "node_group" {
    cluster_name            = var.cluster_name
    node_group_name         = var.node_group_name
    node_role_arn           = var.node_role
    subnet_ids              = var.subnet_ids

    instance_types          = var.instance_types
    disk_size               = var.disk_size
    force_update_version    = var.force_update
    labels                  = var.node_labels

    scaling_config {
      desired_size      = var.scaling_settings.desired_size
      max_size          = var.scaling_settings.max_size
      min_size          = var.scaling_settings.min_size
    }

    update_config {
      max_unavailable           = var.update_max_unavailable
    }

    remote_access {
      ec2_ssh_key               = var.ssh_key
      source_security_group_ids = var.security_groups
    }

    tags = {
      Name      = var.node_group_name
      Region    = var.target_region
      Env       = var.target_env
      App       = var.target_app
      Service   = var.target_service
    }
}
