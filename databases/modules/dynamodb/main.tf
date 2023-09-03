resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  attribute {
    name = var.table_hash_name
    type = var.table_hash_type
  }

  attribute {
    name = var.table_range_name
    type = var.table_range_type
  }

  server_side_encryption {
    enabled     = var.table_encryption_enabled
    kms_key_arn = var.table_kms_key
  }

  tags = {
    Name        = var.table_name
    Region      = var.region
    Environment = var.environment
    Service     = var.supported_service
    App         = var.supported_app
  }
}
