#-- General Load Balancer Variables --#

variable "instance_count" {
    type = number
    description = "The number of instances that will be attached to the target group"
}

variable "target_group_settings" {
    type = map(any)
    description = "Target group settings"
}

variable "lb_settings" {
    type = map(any)
    description = "Load balancer settings"
}

variable "listener_settings" {
    type = map(any)
    description = "Listener settings"
}

variable "target_instances" {
    type = list(string)
    description = "A list of target instance ids - This can contain only one instance id but needs to be a list"
}

variable "target_subnets" {
    type = list(string)
    description = "A list of subnets for the load balancer"
}

variable "target_security_groups" {
    type = list(string)
    description = "A list of security groups to attach to the load balancer"
}

variable "instance_port" {
    type = number
    description = "The instance port for the target group" 
}

variable "target_vpc" {
    type = string
    description = "The VPC that the load balancer will be created in"
}

variable "target_region" {
    type = string
    description = "Region that the load balancer will be created in"
}

variable "target_env" {
    type = string
    description = "Environment that the load balancer will be created in"
}

variable "target_app" {
    type = string
    description = "Application that the load balancer is supporting"
}

variable "target_service" {
    type = string
    description = "Service that the load balancer is supporting"
}

