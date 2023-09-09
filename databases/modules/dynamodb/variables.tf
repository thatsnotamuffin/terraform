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
  default     = "Key"
}

variable "point_in_time_recovery" {
  type        = bool
  description = "Enable point in time recovery"
  default     = false
}

variable "table_hash_name" {
  type        = string
  description = "Name of the attribute - Hash"
  default     = "Path"
}

variable "table_hash_type" {
  type        = string
  description = "Attribute type - valid values are S (string) - N (number) - B (binary)"
  default     = "S"
}

variable "table_range_name" {
  type        = string
  description = "Name of the attribute - Range"
  default     = "Key"
}

variable "table_range_type" {
  type        = string
  description = "Attribute type - valid values are S (string) - N (number) - B (binary)"
  default     = "S"
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
