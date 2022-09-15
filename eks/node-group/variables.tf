variable "cluster_name" {
    type = string
    description = "Name of the cluster the node group is being created for"
}

variable "node_group_name" {
    type = string
    description = "Name of the node group"
}

variable "node_role_arn" {
    type = string
    description = "Node role arn"
}

variable "subnet_ids" {
    type = list(string)
    description = "A list of subnet IDs for the nodes"
}

variable "instance_types" {
    type = list(string)
    description = "A list of instance types to use for the nodes"
    default = [ "t3.large" ]
}

variable "disk_size" {
    type = number
    description = "Amount of GBs for the node disk"
    default = 20
}

variable "force_update" {
    type = bool
    description = "Force the update of nodes even if existing pods are unable to be drained"
    default = true
}

variable "node_labels" {
    type = map(string)
    description = "A map of the labels to apply to the node group"
}

variable "scaling_settings" {
    type = map(number)
    description = "A map of scaling settings - desired_size (num) , max_size (num) , min_size (num)"
}

variable "update_max_unavailable" {
    type = number
    description = "Maximum number of instances that can be unavailable at a time during an update"
    default = 1
}

variable "ssh_key" {
    type = string
    description = "Name of the ssh key to use for the nodes"
}

variable "security_groups" {
    type = list(string)
    description = "A list of security groups to be used for SSH access to the nodes"
}

variable "target_region" {
    type = string
    description = "The region the nodes are being created in"
}

variable "target_env" {
    type = string
    description = "The environment the nodes are being created for"
}

variable "target_app" {
    type = string
    description = "The application the nodes are supporting"
}

variable "target_service" {
    type = string
    description = "The service the nodes are supporting"
}
