variable "notamuffin_rds_username" {
  type        = string
  description = "Username for notamuffin RDS database"
  sensitive   = true
}

variable "notamuffin_rds_password" {
  type        = string
  description = "Password for notamuffin RDS database"
  sensitive   = true
}
