# Tags
variable "tags" {
  type        = map(string)
  description = "A map defining user-supplied tags"
  default     = {}
}

variable "name" {
  type        = string
  description = "Name of the IAM OIDC"
}

variable "description" {
  type        = string
  description = "A description of the OIDC and its purpose"
}

variable "source_terraform" {
  type        = string
  description = "The URL of the Terraform code in the repo this module is used in. NOTE: not the central Terraform repo origin (thatsnotamuffin/terraform)"
}

# OIDC
variable "url" {
  type        = string
  description = "The URL of the identity provider. Corresponds to the iss claim"
}

variable "client_id_list" {
  type        = list(string)
  description = "A list of client IDs (also known as audiences)"
}

variable "thumbprint_list" {
  type        = list(string)
  description = "A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)"
}
