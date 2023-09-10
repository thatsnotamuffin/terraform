# Tags
variable "environment" {
  type        = string
  description = "The environment the resources are being created for; Production - Staging - Development"
  default     = "Development"
}

variable "region" {
  type        = string
  description = "The region the resources are being created in - AWS region like us-east-1"
  default     = "us-east-1"
}

variable "domain_environment" {
  type        = string
  description = "Domain environment this resource will be created in - kastage - pilyr - prod-ue1 - prod-ew1"
}

# Networking and Security
variable "web_vpc" {
  type        = string
  description = "The VPC to create the Web resources"
}

variable "web_subnets" {
  type        = list(string)
  description = "List of the web subnets the resources will exist in"
}

variable "nginx_web_security_group_name" {
  type        = string
  description = "Name of the NGINX web group to allow HTTP and HTTPS traffic - should include the environment name; pilyr, kastage, etc."
}

variable "web_security_groups" {
  type        = list(string)
  description = "List of the security groups to be applied to the resources"
}

variable "nginx_ssl_policy" {
  type        = string
  description = "SSL policy for the loadbalancer"
}

variable "nginx_enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection on the ALB"
  default     = false
}

#- EC2 Instance Settings
# General
variable "ebs_kms_key" {
  type        = string
  description = "ARN of the EBS KMS Key"
}

variable "ssh_key" {
  type        = string
  description = "Name of the SSH Key"
  default     = "stage-admin"
}

# Server Settings
variable "nginx_instance_names" {
  type        = list(string)
  description = "NGINX instance names"
}

variable "nginx_count" {
  type        = number
  description = "The number of NGINX instances to create"
  default     = 1
}

variable "nginx_ami" {
  type        = string
  description = "AMI to use as the base image"
}

variable "nginx_instance_type" {
  type        = string
  description = "The EC2 instance type - refer to AWS documentation on available instance types in a region"
  default     = "t3.small"
}

variable "nginx_root_vol_size" {
  type        = number
  description = "The size of the root volume on the NGINX instance"
  default     = 50
}

# Loadbalancer Listener and Target Group
variable "nginx_tg_name" {
  type        = string
  description = "Name of the target group for NGINX"
}

variable "nginx_lb_name" {
  type        = string
  description = "Name of the NGINX Application Loadbalancer"
}

variable "nginx_lb_access_logs_enabled" {
  type        = bool
  description = "Enable Access Logs"
  default     = false
}

variable "alb_logs_bucket" {
  type        = string
  description = "Name of the S3 bucket to send access logs to"
  default     = "null"
}

variable "nginx_cert_arn" {
  type        = string
  description = "ARN of the SSL certificate in ACM"
}

variable "nginx_https_listener_name" {
  type        = string
  description = "Name of the NGINX HTTPS listener"
}

variable "nginx_http_listener_name" {
  type        = string
  description = "Name of the NGINX HTTP listener"
}

# Route53
variable "nginx_zone_id" {
  type        = string
  description = "Zone ID for NGINX"
}

variable "nginx_route53_name" {
  type        = string
  description = "Name of the Route53 record"
}

variable "nginx_hostnames" {
  type        = list(string)
  description = "List of hostnames for the NGINX servers"
}
