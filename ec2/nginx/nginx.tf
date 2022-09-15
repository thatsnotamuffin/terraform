##-- NGINX EC2 Instance Configuration --##

# This module creates a set of NGINX instances - an associated application load balancer - and route53 entries #

# Create Security Group to allow web traffic to NGINX
resource "aws_security_group" "allow_web" {
    name                  = var.security_group_name
    description           = "Allow web traffic to NGINX servers for ${var.target_env}"

    vpc_id                = var.target_vpc

    ingress {
        cidr_blocks       = [ "0.0.0.0/0" ]
        description       = "IPv4 HTTPS"
        from_port         = 443
        ipv6_cidr_blocks  = [ "::/0" ]
        protocol          = "TCP"
        self              = false
        to_port           = 443
    }
    
    ingress {
        cidr_blocks       = [ "0.0.0.0/0" ]
        description       = "IPv4 HTTP"
        from_port         = 80
        ipv6_cidr_blocks  = [ "::/0" ]
        protocol          = "TCP"
        self              = false
        to_port           = 80
    }
    
    egress {
      from_port           = 0
      to_port             = 0
      protocol            = "-1"
      cidr_blocks         = ["0.0.0.0/0"]
      ipv6_cidr_blocks    = ["::/0"]
    }

    tags = {
      Name                = var.security_group_name
      Env                 = var.target_env
    }
}

# Combine variable security groups and the created web security group in order to be deployed on the created NGINX ALB
locals {
  all_security_groups = setunion(
    var.target_security_groups, [aws_security_group.allow_web.id]
  )
}

#- EC2 Instances
resource "aws_instance" "ec2_nginx" {
    count                               = var.nginx_count

    # General Instance Info
    ami                                 = var.general_instance_settings.global_ami
    instance_type                       = var.nginx_instance_type

    # Block Device - Root
    root_block_device {
      volume_type                       = var.general_instance_settings.vol_type
      volume_size                       = var.general_instance_settings.root_vol_size
      encrypted                         = var.general_instance_settings.encrypted_volume
      kms_key_id                        = var.general_instance_settings.kms_key

      # Tags - Required below
      tags = {
          Name                          = "nginx-root-vol-${count.index + 1}"
          Region                        = var.target_region
          Env                           = var.target_env
          Service                       = "NGINX"
          App                           = "N/A"
      }
    }

    # Security Groups
    vpc_security_group_ids              = var.target_security_groups

    # Networking
    subnet_id                           = var.web_subnets[count.index]

    # Miscellaneous
    key_name                            = var.general_instance_settings.ssh_key
    tags = {
        Name                            = var.nginx_instance_names[count.index]
        Region                          = var.target_region
        Env                             = var.target_env
        Service                         = "NGINX"
        App                             = "N/A"
    }
}

# Attach created HTTP / HTTPS security group to NGINX instances
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  count                                 = var.nginx_count

  security_group_id                     = aws_security_group.allow_web.id
  network_interface_id                  = aws_instance.ec2_nginx[count.index].primary_network_interface_id
}

#- Target Group
resource "aws_lb_target_group" "nginx_tg" {
    target_type                         = var.nginx_tg_settings.nginx_target_type
    name                                = var.nginx_tg_settings.nginx_tg_name
    port                                = var.nginx_tg_settings.port
    protocol                            = var.nginx_tg_settings.protocol
    vpc_id                              = var.target_vpc

    health_check {
      path                              = "/"
      port                              = var.nginx_tg_settings.port
      protocol                          = var.nginx_tg_settings.protocol
      interval                          = 30
      healthy_threshold                 = 5
      unhealthy_threshold               = 5
      matcher                           = "200"
    }

    depends_on = [
      aws_instance.ec2_nginx
    ]
}

resource "aws_lb_target_group_attachment" "nginx_tg_attach" {
    count                               = var.nginx_count
    target_group_arn                    = aws_lb_target_group.nginx_tg.arn
    target_id                           = aws_instance.ec2_nginx[count.index].id
    port                                = 80

    depends_on = [
      aws_lb_target_group.nginx_tg
    ]
}

#- Load Balancers and Listeners
resource "aws_lb" "nginx_alb" {
    name                                = var.nginx_lb_settings.lb_name
    internal                            = var.nginx_lb_settings.internal
    load_balancer_type                  = var.nginx_lb_settings.loadbalancer_type
    security_groups                     = local.all_security_groups
    subnets                             = var.web_subnets
    enable_deletion_protection          = var.nginx_lb_settings.deletion_protection

    tags = {
        Name                            = var.nginx_lb_settings.lb_name
        Region                          = var.target_region
        Env                             = var.target_env
        App                             = "N/A"
        Service                         = "NGINX"
    }

    depends_on = [
      aws_lb_target_group_attachment.nginx_tg_attach
    ]
}

resource "aws_lb_listener" "nginx_listener_https" {
    load_balancer_arn                   = aws_lb.nginx_alb.arn
    port                                = var.nginx_https_listener.port
    protocol                            = var.nginx_https_listener.protocol
    ssl_policy                          = var.nginx_https_listener.ssl_policy
    certificate_arn                     = var.nginx_https_listener.certificate_arn

    default_action {
        type                            = var.nginx_https_listener.default_action_type
        target_group_arn                = aws_lb_target_group.nginx_tg.arn
    }

    tags = {
        Name                            = var.nginx_https_listener.listener_name
        Region                          = var.target_region
        Env                             = var.target_env
        App                             = "N/A"
        Service                         = "NGINX"
    }

    depends_on = [
      aws_lb.nginx_alb
    ]
}

resource "aws_lb_listener" "nginx_listener_http" {
    load_balancer_arn                   = aws_lb.nginx_alb.arn
    port                                = var.nginx_http_listener.port
    protocol                            = var.nginx_http_listener.protocol

    default_action {
        type                            = var.nginx_http_listener.default_action_type
        target_group_arn                = aws_lb_target_group.nginx_tg.arn
    }

    tags = {
        Name                            = var.nginx_http_listener.listener_name
        Region                          = var.target_region
        Env                             = var.target_env
        App                             = "N/A"
        Service                         = "NGINX"
    }

    depends_on = [
      aws_lb.nginx_alb
    ]
}

#- Route53
resource "aws_route53_record" "base_domain" {
    zone_id                             = var.r53_base_domain.zone_id
    name                                = var.r53_base_domain.name
    type                                = var.r53_base_domain.type

    alias {
        name                            = aws_lb.nginx_alb.dns_name
        zone_id                         = aws_lb.nginx_alb.zone_id
        evaluate_target_health          = true
    }

    depends_on = [
      aws_lb.nginx_alb
    ]
}

resource "aws_route53_record" "wildcard_base_domain" {
    zone_id                             = var.r53_wildcard_base_domain.zone_id
    name                                = var.r53_wildcard_base_domain.name
    type                                = var.r53_wildcard_base_domain.type

    alias {
        name                            = aws_lb.nginx_alb.dns_name
        zone_id                         = aws_lb.nginx_alb.zone_id
        evaluate_target_health          = true
    }

    depends_on = [
      aws_lb.nginx_alb
    ]
}

resource "aws_route53_record" "nginx_instance_records" {
  count       = length(aws_instance.ec2_nginx)
  zone_id     = var.r53_base_domain.zone_id
  ttl         = var.r53_base_domain.ttl
  type        = var.r53_base_domain.type
  name        = var.nginx_hostnames[count.index]
  records     = [aws_instance.ec2_nginx[count.index].private_ip]

  depends_on = [
    aws_instance.ec2_nginx
  ]
}
