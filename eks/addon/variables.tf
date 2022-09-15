variable "cluster_name" {
    type = string
    description = "The name of the EKS cluster"
}

variable "target_addon" {
    type = string
    description = "The name of the Addon to be created"
}

variable "version" {
    type = string
    description = "The version of the addon - must be one of the versions found with the aws eks describe-addon-versions command using AWS CLI"
}
