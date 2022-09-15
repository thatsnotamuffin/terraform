##-- NGINX EC2 Variables --##

# This contains the various variables used in the nginx.tf file as well as some applicable defaults

#- General
variable "nginx_count" {
    type = number
    description             = "The number of NGINX servers to be created"
    default                 = 2
}

#- Security
variable "target_security_groups" {
    type = list(string)
    description             = "A list of security groups to be applied to the NGINX resources"
}

variable "security_group_name" {
    type = string
    description             = "The name of the security group to create to allow web traffic to the NGINX servers"
  
}

#- Network
variable "target_vpc" {
    type = string
    description             = "The target VPC to create the NGINX resources"
}

variable "web_subnets" {
    type = list(string)
    description             = "The public subnets that these resources will be created in - typically named web-a and web-b - this variable requires the subnet-id values"
}

variable "target_env" {
    type = string
    description             = "The target environment - I.E. prod-us"
}

variable "target_region" {
    type = string
    description             = "The target region - I.E. us-east-1"
}

#- EC2 Instances Settings
variable "general_instance_settings" {
    type = map(any)
    description             = "A map of the general instance settings - Consists of global_ami (str) , encrypted_volume (bool) , vol_type (str) , root_vol_size (int) , ssh_key (str) , kms_key (arn as str)"
}

variable "nginx_instance_type" {
    type = string
    description             = "Instance Type for the NGINX servers"
    default                 = "t3.small"
}

# DNS
variable "nginx_instance_names" {
    type = list(string)
    description             = "A list of the NGINX instance names - this is used for DNS"
    default                 = ["nginx-1", "nginx-2"]
}

# Target Group
variable "nginx_tg_settings" {
    type = map(any)
    description             = "A map of the NGINX target group settings"
    default = {
        nginx_target_type   = "instance"
        nginx_tg_name       = "nginx-tg"
        port                = 80
        protocol            = "HTTP"
    }
}

# Load Balancer 
variable "nginx_lb_settings" {
    type = map(any)
    description             = "A map of the NGINX load balancer settings"
    default = {
        lb_name             = "nginx-alb"
        internal            = false
        loadbalancer_type   = "application"
        deletion_protection = false
    }
}

# Listeners
variable "nginx_https_listener" {
    type = map(string)
    description             = "A map of the NGINX HTTPS listener settings"
    default = {
        port                = "443"
        protocol            = "HTTPS"
        ssl_policy          = "ELBSecurityPolicy-FS-1-2-2019-08"
        certificate_arn     = "cert_arn"
        default_action_type = "forward"
        listener_name       = "nginx-https"
    }
}

variable "nginx_http_listener" {
    type = map(string)
    description             = "A map of the NGINX HTTP listener settings"
    default = {
        port                = "80"
        protocol            = "HTTP"
        default_action_type = "forward"
        listener_name       = "nginx-http"
    }
}

# Route53 - DNS
variable "r53_base_domain" {
    type = map(string)
    description             = "A map of the Route53 Base Domain settings - zone_id (str) , name (str) , type (str)"
}

variable "r53_wildcard_base_domain" {
    type = map(string)
    description             = "A map of the Route53 Wildcard Base Domain settings - zone_id (str) , name (str) , type(str)"
}

variable "nginx_hostnames" {
    type = list(string)
    description             = "A list of hostnames for the nginx servers"
}

