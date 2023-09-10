# Tags
variable "region" {
  type        = string
  description = "Region the resources are created in"
}

variable "environment" {
  type        = string
  description = "Environment the resources are created for"
}

variable "supported_service" {
  type        = string
  description = "Service the resources support"
  default     = "Elasticsearch 7.1"
}

variable "supported_app" {
  type        = string
  description = "App the resources support"
}

variable "cluster_name" {
  type        = string
  description = "Name of the Elasticsearch cluster"
}

variable "cluster_description" {
  type        = string
  description = "Description of the Elasticsearch cluster"
}

# Networking and Security
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to apply to the cluster"
}

variable "subnets" {
  type        = list(string)
  description = "List of Subnet IDs"
}

# EC2
variable "cluster_count" {
    type = number
    description = "Number of instances in the Elasticsearch cluster"  
}

variable "ami" {
  type        = string
  description = "AMI to use as the base image"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the cluster"
}

variable "volume_size" {
  type        = number
  description = "Size of the root volume in GB"
  default     = 50
}

variable "kms_key_id" {
  type        = string
  description = "ARN of the KMS key used to encrypt the root device"
}

variable "ssh_key" {
  type        = string
  description = "Name of the SSH key"
}

variable "instance_names" {
  type        = list(string)
  description = "List of instance names"
}

variable "data_vol_ids" {
  type        = list(string)
  description = "List of volume IDs for the data volumes"
}

variable "data_vol_destroy" {
  type        = bool
  description = "Set this to true if  you want to detach the volume from the instance at destroy time"
  default     = true
}

# Target Group
variable "tg_name" {
  type        = string
  description = "Name of the Target Group"
}

# Loadbalancer and Listener
variable "lb_name" {
  type        = string
  description = "Name of the ALB"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection on the ALB"
}

variable "access_logs_enabled" {
  type        = bool
  description = "Enable Access Logs"
  default     = false
}

variable "access_logs_bucket" {
  type        = string
  description = "S3 bucket to send access logs to"
  default     = null
}

variable "ssl_policy" {
  type        = string
  description = "SSL policy to apply to the ALB listener"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the SSL certificate in ACM"
}

variable "es_listener_name" {
  type        = string
  description = "Name of the ALB listener"
}

# Route53
variable "zone_id" {
  type        = string
  description = "Route53 zone ID"
}

variable "cluster_dns_name" {
  type        = string
  description = "Cluster DNS name"
}

variable "hostnames" {
  type        = list(string)
  description = "List of hostnames for the cluster"
}
