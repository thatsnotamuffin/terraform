# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "name" {
  type        = string
  description = "Name of the VPC"
}

variable "region" {
  type        = string
  description = "Region the VPC is created in"
  default     = "us-east-1"
}

# VPC
variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "A boolean flag to enable or disable DNS hostnames in the VPC"
  default     = false
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable or disable DNS support in the VPC"
  default     = true
}

# DHCP
variable "dhcp_options_enabled" {
  type        = bool
  description = "Enable DHCP Options"
  default     = false
}

variable "domain_name" {
  type        = string
  description = "The suffix domain name to use by default when resolving non Fully Qualified Domain Names"
  default     = null
}

variable "domain_name_servers" {
  type        = list(string)
  description = "List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS"
  default     = null # ["AmazonProvidedDNS"]
}
