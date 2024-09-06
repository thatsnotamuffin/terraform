# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "region" {
  type        = string
  description = "AWS region the resource is created in"
  default     = "us-east-1"
}

variable "name" {
  type        = string
  description = "Name of the subnet"
}

# Subnet
variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for the subnet"
  default     = null
}

variable "availability_zone_id" {
  type        = string
  description = "Availability Zone ID of the subnet. This argument is not supported in all regions or partitions"
  default     = null
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
  default     = false
}
