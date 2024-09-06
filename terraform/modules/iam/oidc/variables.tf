# Tags
variable "purpose" {
  type        = string
  description = "Why the OIDC was created"
}

variable "created_by" {
  type        = string
  description = "Who created the OIDC - First and Last name - Contact email address"
}

variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

# OIDC
variable "url" {
  type        = string
  description = "The URL of the identity provider. Corresponds to the iss claim"
}

variable "client_id_list" {
  type        = string
  description = "A list of client IDs (also known as audiences)"
}

variable "thumbprint_list" {
  type        = string
  description = "A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)"
}
