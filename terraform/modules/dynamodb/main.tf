resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  table_class    = var.table_class
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  hash_key  = var.hash_key
  range_key = var.range_key

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attributes.value.name
      type = attributes.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index

    content {
      hash_key           = lookup(global_secondary_index.value, "hash_key", null)
      name               = lookup(global_secondary_index.value, "name", null)
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = lookup(global_secondary_index.value, "projection_type", null)
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index

    content {
      name               = lookup(local_secondary_index.value, "name", null)
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = lookup(local_secondary_index.value, "projection_type", null)
      range_key          = lookup(local_secondary_index.value, "range_key", null)
    }
  }

  dynamic "replica" {
    for_each = var.replica

    content {
      kms_key_arn            = lookup(replica.value, "kms_key_arn", null)
      point_in_time_recovery = lookup(replica.value, "point_in_time_recovery", null)
      propagate_tags         = lookup(replica.value, "propagate_tags", null)
      region_name            = lookup(replica.value, "region_name", null)
    }
  }

  ttl {
    attribute_name = var.ttl_attribute_name
    enabled        = var.ttl_enabled
  }

  server_side_encryption {
    enabled     = var.table_encryption_enabled
    kms_key_arn = var.table_kms_key
  }

  tags = merge({
    Name        = var.table_name
    Region      = var.region
    Environment = var.environment
    Service     = var.supported_service
    App         = var.supported_app
  }, var.tags)
}
