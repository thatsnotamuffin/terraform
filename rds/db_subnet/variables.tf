#- DB Subnet Group Variables -#

variable "db_subnets" {
    type = list(string)
    description = "List of DB Subnets to create the RDS instance and subnet group in"
}

variable "rds_subnet_group_settings" {
    type = map(any)
    description = "A map of the RDS Subnet Group settings - subnet_group_name (str) , target_region (str) , target_env (str) , target_service (str)"
}
