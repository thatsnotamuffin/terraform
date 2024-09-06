# Tags
variable "region" {
  type        = string
  description = "Region the EKS cluster is deployed in"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment the cluster is deployed in"
  default     = "Development"
}

variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied -tags"
  default     = {}
}

# EKS
variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes <major>.<minor> version of the cluster I.E. 1.30"
  default     = null
}

variable "cluster_enabled_log_types" {
  type        = list(string)
  description = "A list of the desired control plane logs to enable"
  default     = ["audit", "api", "authenticator"]
}

# Networking
variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = false
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the cluster security group will be provisioned"
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs where the nodes/node groups will be provisioned. If `control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets"
  default     = []
}

variable "control_plane_subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  default     = []
}

# Node Group
variable "eks_managed_node_group_defaults_instance_types" {
  type        = string
  description = "Default instance types for EKS managed node groups"
  default     = "m6i.large"
}

variable "ami_id" {
  type        = string
  description = "The AMI from which to launch the instance. If not supplied, EKS will use its own default image"
  default     = "ami-0a1207755444805af"
}

variable "ami_type" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  default     = "AL2023_x86_64_STANDARD"
}

variable "instance_types" {
  type        = list(string)
  description = "Set of instance types associated with the EKS Node Group"
  default     = ["m6i.large"]
}

variable "min_size" {
  type        = number
  description = "Minimum amount of nodes available to the cluster"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Maximum amount of nodes to provision to the cluster"
  default     = 10
}

variable "desired_size" {
  type        = number
  description = "Desired amount of nodes"
  default     = 3
}

# EBS - Storage
variable "delete_on_termination" {
  type        = bool
  description = "Delete volume on termination of the EC2 instance"
  default     = true
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot ID to create EBS volumes from"
  default     = null
}

variable "iops" {
  type        = number
  description = "EBS Volume iops"
  default     = 3000
}

variable "throughput" {
  type        = number
  description = "EBS Volume Throughput"
  default     = 125
}

variable "volume_size" {
  type        = number
  description = "Size of the EBS volume"
  default     = 50
}

variable "volume_type" {
  type        = string
  description = "EBS Volume Type"
  default     = "gp3"
}

# Authentication
variable "enable_cluster_creator_admin_permissions" {
  type        = bool
  description = "Indicates whether or not to add the cluster creator (the identity used by Terraform) as an administrator via access entry"
  default     = false
}
