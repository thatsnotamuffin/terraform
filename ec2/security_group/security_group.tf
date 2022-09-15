##-- EC2 Security Groups --##

# This terraform module creates EC2 Security groups
# A data object is used within a dynamic block for the ingress and egress blocks to allow for multiple ingress and egress rules

resource "aws_security_group" "security_group" {
    name        = var.security_group_settings.name
    description = var.security_group_settings.description
    vpc_id      = var.security_group_settings.vpc_id

    dynamic "ingress" {
        for_each = var.ingress_rules
        
        content {
            description         = ingress.value.description
            from_port           = ingress.value.from_port
            to_port             = ingress.value.to_port
            protocol            = ingress.value.protocol
            cidr_blocks         = ingress.value.ipv4_cidr_blocks
        }
    }

    dynamic "egress" {
        for_each = var.egress_rules

        content {
            description         = egress.value.description
            from_port           = egress.value.from_port
            to_port             = egress.value.to_port
            protocol            = egress.value.protocol
            cidr_blocks         = egress.value.ipv4_cidr_blocks
            ipv6_cidr_blocks    = egress.value.ipv6_cidr_blocks
        }
    }

    tags = {
      Name      = var.security_group_settings.name
      Region    = var.security_group_settings.target_region
      Env       = var.security_group_settings.target_env
      App       = var.security_group_settings.target_app
      Service   = var.security_group_settings.target_service
    }
}

