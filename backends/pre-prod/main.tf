terraform {
  backend "s3" {
    bucket         = "terraform-pre-prod"
    key            = "global/backend/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/terraform-pre-prod"
    dynamodb_table = "terraform-pre-prod"
  }
}

##-- KMS Key and Alias --##
resource "aws_kms_key" "terraform_bucket_key" {
  description             = "This key is used to encrypt Terraform bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Name         = "terraform-pre-prod"
    Region       = "us-east-1"
    Environment  = "pre-prod"
    Created_Date = "${timestamp()}"
  }
}

resource "aws_kms_alias" "bucket_key_alias" {
  name          = "alias/terraform-pre-prod"
  target_key_id = aws_kms_key.terraform_bucket_key.key_id

  depends_on = [
    aws_kms_key.terraform_bucket_key
  ]
}

##-- S3 Bucket and DynamoDB Table for state files and state lock --##
#- S3 Bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-pre-prod"

  tags = {
    Name         = "terraform-pre-prod"
    Region       = "us-east-1"
    Environment  = "pre-prod"
    Created_Date = "${timestamp()}"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption_config" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }

  depends_on = [
    aws_s3_bucket.terraform_state
  ]
}

resource "aws_s3_bucket_ownership_controls" "state_acl_ownership" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [
    aws_s3_bucket.terraform_state
  ]
}

resource "aws_s3_bucket_acl" "state_bucket_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"

  depends_on = [
    aws_s3_bucket.terraform_state,
    aws_s3_bucket_ownership_controls.state_acl_ownership
  ]
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [
    aws_s3_bucket.terraform_state
  ]
}

resource "aws_s3_bucket_versioning" "state_bucket_version" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [
    aws_s3_bucket.terraform_state
  ]
}

#- DynamoDB Table
resource "aws_dynamodb_table" "terraform_dynamodb_state" {
  name           = "terraform-pre-prod"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name         = "terraform-pre-prod"
    Region       = "us-east-1"
    Environment  = "pre-prod"
    Created_Date = "${timestamp()}"
  }
}
