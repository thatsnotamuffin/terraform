##-- General EC2 Load Balancer Configuration --##

# This module creates a general load balancer and target groups

#- Target Group
resource "aws_lb_target_group" "lb_target_group" {
    target_type                     = var.target_group_settings.target_group_type
    name                            = var.target_group_settings.target_group_name
    port                            = var.target_group_settings.port
    protocol                        = var.target_group_settings.protocol
    vpc_id                          = var.target_vpc

    health_check {
      path                          = var.target_group_settings.path
      port                          = var.target_group_settings.health_port
      protocol                      = var.target_group_settings.health_protocol
      interval                      = var.target_group_settings.health_interval
      healthy_threshold             = var.target_group_settings.healthy_threshold
      unhealthy_threshold           = var.target_group_settings.unhealthy_threshold
      matcher                       = var.target_group_settings.health_matcher
    }
}

# Attach the EC2 instance(s) to the target group
resource "aws_lb_target_group_attachment" "ec2_tg_attach" {
    # Instance count is used for the amount of instances to attach to the target group - allows for a loop without having to repeat this resource block an unknown number of times
    instance_count                  = var.instance_count
    target_group_arn                = aws_lb_target_group.lb_target_group.arn
    # target_instances is a list of the instance ids for the target instances - while it does require a list it can contain only a single instance or multiple instance ids
    target_id                       = var.target_instances[count.index]
    port                            = var.instance_port
}

# Load balancer
resource "aws_lb" "general_lb" {
    name                            = var.lb_settings.lb_name
    internal                        = var.lb_settings.internal
    load_balancer_type              = var.lb_settings.load_balancer_type
    security_groups                 = var.target_security_groups
    subnets                         = var.target_subnets
    enable_deletion_protection      = var.lb_settings.deletion_protection

    tags = {
        Name                        = var.lb_settings.lb_name
        Region                      = var.target_region
        Env                         = var.target_env
        App                         = var.target_app
        Service                     = var.target_service
    }
}

# Listener
resource "aws_lb_listener" "general_listener" {
    load_balancer_arn               = aws_lb.general_lb.arn
    port                            = var.listener_settings.port
    protocol                        = var.listener_settings.protocol
    ssl_policy                      = var.listener_settings.ssl
    certificate_arn                 = var.listener_settings.cert_arn

    default_action {
      type                          = var.listener_settings.default_action_type
      target_group_arn              = aws_lb_target_group.lb_target_group.arn
    }

    tags = {
        Name                        = var.listener_settings.listener_name
        Region                      = var.target_region
        Env                         = var.target_env
        App                         = var.target_app
        Service                     = var.target_service
    } 
}

