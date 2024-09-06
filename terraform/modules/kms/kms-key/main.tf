resource "aws_kms_key" "kms_key" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation

  tags = {
    Name        = var.kms_key_alias
    Purpose     = var.purpose
    Region      = var.region
    Environment = var.environment
    Managed_By  = "Terraform"
  }
}

resource "aws_kms_alias" "kms_alias" {
  name          = var.kms_key_alias
  target_key_id = aws_kms_key.kms_key.key_id

  depends_on = [
    aws_kms_key.kms_key
  ]
}
