#- DynamoDB Variables -#

variable "dynamodb_settings" {
    type = map(any)
    description = "Map of the DynamoDB settings - table_name (str) , billing_mode (str) , read_cap (int) , write_cap (int) , hash (str) , hash_type (str) , range(str) , range_type (str) , target_region (str) , target_env (str) , target_app (str) , target_service (str)"
}

