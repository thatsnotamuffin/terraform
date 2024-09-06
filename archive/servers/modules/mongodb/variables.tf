# Tags
variable "region" {
  type        = string
  description = "Region the resources are being created in"
}

variable "environment" {
  type        = string
  description = "Environment the resources are being created for"
}

variable "supported_service" {
  type        = string
  description = "Service the resources support"
}

variable "supported_app" {
  type        = string
  description = "App the resources support"
}

# Networking and Security
variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "db_subnets" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "arbiter_subnet" {
  type        = string
  description = "Subnet ID for the arbiter subnet"
}

# EC2 Instance
variable "replset_count" {
  type        = number
  description = "Number of data instances in the replication set"
}

variable "ami" {
  type        = string
  description = "AMI to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "volume_size" {
  type        = number
  description = "Size of the root EBS volume"
  default     = 50
}

variable "volume_type" {
  type        = string
  description = "Volume type for the root volume"
  default     = "gp3"
}

variable "kms_key_id" {
  type        = string
  description = "ARN of the KMS key"
}

variable "ssh_key" {
  type        = string
  description = "Name of the SSH key"
}

variable "mongo_replset" {
  type        = string
  description = "Name of the MongoDB replication set"
}

variable "mongo_description" {
  type        = string
  description = "Description of the MongoDB replication set"
}

variable "replset_instance_names" {
  type        = list(string)
  description = "List of the replication set instance names"
}

variable "mongo_hostnames" {
  type        = list(string)
  description = "A list of hostnames for the mongo data instances"
}

variable "arbiter_instance_name" {
  type        = string
  description = "Name of the arbiter instance"
}

variable "arbiter_hostname" {
  type        = string
  description = "Hostname of the arbiter instance"
}

variable "data_vol_ids" {
  type        = list(string)
  description = "A list of EBS volume IDs for the mongo data volumes"
}

variable "arbiter_data_vol" {
  type        = string
  description = "Volume ID for the arbiter instance data volume"
}

variable "data_vol_destroy" {
  type        = bool
  description = "Set this to true if you want to detach the volume from the instance at destroy time"
}

# Route53
variable "zone_id" {
  type        = string
  description = "Zone ID for the Route53 zone"
}
