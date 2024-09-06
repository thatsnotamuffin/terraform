# Tags
variable "region" {
  type        = string
  description = "Region the DynamoDB Table is deployed in"
}

variable "environment" {
  type        = string
  description = "Environment the table is deployed in"
}

variable "supported_app" {
  type        = string
  description = "Application the DynamoDB table supports"
}

variable "supported_service" {
  type        = string
  description = "Service the DynamoDB table supports"
}

variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied"
  default     = {}
}

# Table Settings
variable "table_name" {
  type        = string
  description = "Name of the DynamoDB Table"
}

variable "billing_mode" {
  type        = string
  description = "Billing mode for the DynamoDB table"
  default     = "PROVISIONED"
}

variable "table_class" {
  type        = string
  description = "Storage class of the table. Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS"
  default     = "STANDARD"
}

variable "read_capacity" {
  type        = number
  description = "Number of read units"
  default     = 15
}

variable "write_capacity" {
  type        = number
  description = "Number of write units"
  default     = 15
}

variable "hash_key" {
  type        = string
  description = "Attribute as the hash (partition) key"
  default     = "Path"
}

variable "range_key" {
  type        = string
  description = "Attribute to use as the range (sort) key"
  default     = null
}

variable "point_in_time_recovery" {
  type        = bool
  description = "Enable point in time recovery"
  default     = false
}

variable "attributes" {
  type = list(object({
    name = string # Name of the attribute
    type = string # Attribute type. Valid values are S (string), N (number), B (binary)
  }))
  default = []
}

variable "global_secondary_index" {
  type        = any
  description = "Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc."
  default     = {}
}

variable "local_secondary_index" {
  type        = any
  description = " Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource"
  default     = {}
}

variable "replica" {
  type        = any
  description = "Configuration block(s) with DynamoDB Global Tables V2 (version 2019.11.21) replication configurations"
  default     = {}
}

variable "ttl_enabled" {
  type        = bool
  description = "Name of the table attribute to store the TTL timestamp in. Required if enabled is true, must not be set otherwise"
  default     = false
}

variable "ttl_attribute_name" {
  type        = string
  description = "Whether TTL is enabled"
  default     = null
}

variable "table_encryption_enabled" {
  type        = bool
  description = "Enable encryption"
  default     = true
}

variable "table_kms_key" {
  type        = string
  description = "ARN of the KMS Key to encrypt"
}
