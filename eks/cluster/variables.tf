variable "cluster_name" {
    type = string
    description = "Name of the EKS cluster"
}

variable "version" {
    type = string
    description = "The EKS cluster version to be deployed. Downgrades to previous versions are not allowed - only upgrades"
}

variable "cluster_role" {
    type = string
    description = "Role Arn for the EKS cluster role"
}

variable "subnet_ids" {
    type = list(string)
    description = "List of the subnet IDs for the EKS cluster - 2 Availability Zones are required - only the higher availability zone is evaulated - I.E. us-east-1a , us-east-1b"
}

variable "public_access" {
    type = bool
    description = "Allow public access to the EKS cluster"
    default = true
}

variable "private_access" {
    type = bool
    description = "Allow private access to the EKS cluster"
    default = false
}

variable "security_group_ids" {
    type = list(string)
    description = "A list of the security group IDs to attach to the EKS cluster"
}

variable "cluster_log_types" {
    type = list(string)
    description = "A list of the Cluster Log Types"
    default = [ "api", "authenticator" ]
}

variable "target_region" {
    type = string
    description = "The region the EKS cluster is being created in"
}

variable "target_env" {
    type = string
    description = "The environment the EKS cluster is being created for"
}

variable "target_app" {
    type = string
    description = "The App the cluster is being created for - currently this is not applicable"
    default = "N/A"
}

variable "target_service" {
    type = string
    description = "The Service the EKS cluster is supporting - I.E. Jenkins - ArgoCD"
    default = "My Application"
}
