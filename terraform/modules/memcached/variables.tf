# Tags
variable "region" {
  type        = string
  description = "Region the cluster is deployed in"
}

variable "environment" {
  type        = string
  description = "Environment the cluster is deployed in"
}

variable "supported_service" {
  type        = string
  description = "Service the memcached cluster supports"
}

variable "supported_app" {
  type        = string
  description = "App the memcached cluster supports"
}

# Subnet Group
variable "subnet_group_name" {
  type        = string
  description = "Name of the subnet group"
}

variable "subnet_group_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

# Cluster
variable "cluster_id" {
  type        = string
  description = "Name of the memcached cluster"
}

variable "node_type" {
  type        = string
  description = "Instance class to be used - Refer to AWS documentation for valid instance types"
  default     = "cache.t3.medium"
}

variable "num_cache_nodes" {
  type        = number
  description = "Number of nodes for the Memcached cluster"
  default     = 2
}

variable "parameter_group_name" {
  type        = string
  description = "Parameter group name to apply to the cluster"
  default     = "default.memcached1.6"
}

variable "port" {
  type        = number
  description = "Port to use for the cache nodes"
  default     = 11211
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "apply_immediately" {
  type        = bool
  description = "Apply changes immediately"
  default     = false
}

variable "maintenance_window" {
  type        = string
  description = "The weekly time range for when the maintenance window is performed - ddd:hh24:mi-ddd:hh24:mi - I.E. sun:05:00-sun:09:00"
  default     = "sun:05:00-sun:09:00"
}
