# Source Module: https://github.com/terraform-aws-modules/terraform-aws-eks
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # Cluster Settings
  cluster_name              = var.cluster_name
  cluster_version           = var.cluster_version
  cluster_enabled_log_types = var.cluster_enabled_log_types

  # Networking
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  control_plane_subnet_ids        = var.control_plane_subnet_ids

  # Add-Ons
  cluster_addons = {
    vpc-cni = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  # Node Group
  eks_managed_node_group_defaults = {
    instance_types = var.eks_managed_node_group_defaults_instance_types
  }

  eks_managed_node_groups = {
    worker_group = {
      ami_id         = var.ami_id
      ami_type       = var.ami_type
      instance_types = var.instance_types

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      enable_bootstrap_user_data = true
      pre_bootstrap_user_data    = local.userdata

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            delete_on_termination = var.delete_on_termination
            encrypted             = true
            snapshot_id           = var.snapshot_id
            iops                  = var.iops
            throughput            = var.throughput
            volume_size           = var.volume_size
            volume_type           = var.volume_type
          }
        }
      }
    }
  }

  # Authentication
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  # YMMV - change the access entries as needed
  access_entries = {
    github = {
      kubernetes_groups = []
      principal_arn     = "${data.aws_iam_role.github_role.arn}"

      policy_associations = {
        cluster_view = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  tags = merge({
    Name         = var.cluster_name
    Region       = var.region
    Environment  = var.environment
    Managed_By   = "Terraform"
    Created_Date = "${timestamp}"
  }, var.tags)
}
