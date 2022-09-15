##-- KMS Key Configurations --##

# This module creates KMS keys 
# EBS Volumes
resource "aws_kms_key" "kms_key" {
    description                 = var.kms_key_settings.description
    deletion_window_in_days     = var.kms_key_settings.deletion_window_days
    enable_key_rotation         = var.kms_key_settings.enable_rotation
}

resource "aws_kms_alias" "kms_key_alias" {
    name                        = var.kms_key_settings.alias
    target_key_id               = aws_kms_key.kms_key.key_id

    depends_on = [
        aws_kms_key.kms_key
    ]
}

