##-- DynamoDB --##
# Creates a DynamoDB table

resource "aws_dynamodb_table" "dynamo_table" {
    name                    = var.dynamodb_settings.table_name
    billing_mode            = var.dynamodb_settings.billing_mode
    read_capacity           = var.dynamodb_settings.read_cap
    write_capacity          = var.dynamodb_settings.write_cap
    hash_key                = var.dynamodb_settings.hash
    range_key               = var.dynamodb_settings.range

    attribute {
        name                = var.dynamodb_settings.hash
        type                = var.dynamodb_settings.hash_type
    }

    attribute {
        name                = var.dynamodb_settings.range
        type                = var.dynamodb_settings.range_type
    }

    server_side_encryption {
        enabled             = true
        kms_key_arn         = var.dynamodb_settings.kms_key
    }

    tags = {
        Name                = var.dynamodb_settings.table_name
        Region              = var.dynamodb_settings.target_region
        Env                 = var.dynamodb_settings.target_env
        App                 = var.dynamodb_settings.target_app
        Service             = var.dynamodb_settings.target_service
    }
}
