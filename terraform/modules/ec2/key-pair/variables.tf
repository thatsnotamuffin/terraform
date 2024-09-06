# Tags
variable "purpose" {
  type        = string
  description = "Purpose of the Key Pair"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

# Key Pair
variable "key_name" {
  type        = string
  description = "The name for the key pair"
  default     = null
}

variable "public_key" {
  type        = string
  description = "The public key material I.E. ssh-rsa AAAABBBCCCC email@example.com"
  sensitive   = true
  default     = null
}
