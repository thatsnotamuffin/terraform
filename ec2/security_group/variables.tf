variable "security_group_settings" {
    type = map(string)
    description = "A string map of the security group settings: name , description , vpc_id , target_region , target_env , target_app , target_service"
}

variable "ingress_rules" {
    type = map(object({
        description         = string
        from_port           = number
        to_port             = number
        protocol            = string
        ipv4_cidr_blocks    = list(string)
    }))
}

variable "egress_rules" {
    type = map(object({
        description         = string
        from_port           = number
        to_port             = number
        protocol            = string
        ipv4_cidr_blocks    = list(string)
        ipv6_cidr_blocks    = list(string)
    }))
}

