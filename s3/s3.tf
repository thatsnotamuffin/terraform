##-- S3 Bucket --##
# This deploys S3 buckets listed in the variables.tf file

resource "aws_s3_bucket" "bucket_deploy" {
    for_each                = var.s3_buckets
    bucket                  = "${each.value.target_bucket}"
    force_destroy = true

    tags = {
        "Name"              = "${each.value.target_bucket}"
        "Region"            = "${each.value.target_region}"
        "Environment"       = "${each.value.target_env}"
        "App"               = "${each.value.target_app}"
        "Service"           = "${each.value.target_service}"
    }
}

# ACL - Version 4 of the AWS Provider requires setting the S3 Bucket ACL separately
resource "aws_s3_bucket_acl" "bucket_acl" {
    for_each                = var.s3_buckets
    bucket                  = "${each.value.target_bucket}"
    acl                     = "${each.value.target_acl}"

    depends_on = [
      aws_s3_bucket.bucket_deploy
    ]
}

# Configure Public Access Settings
resource "aws_s3_bucket_public_access_block" "public_access_settings" {
    for_each                = var.s3_buckets
    bucket                  = "${each.value.target_bucket}"

    block_public_acls       = "${each.value.block_public_acl}"
    block_public_policy     = "${each.value.block_public_policy}"
    ignore_public_acls      = "${each.value.ignore_public_acls}"
    restrict_public_buckets = "${each.value.restrict_public_buckets}"

    depends_on = [
      aws_s3_bucket.bucket_deploy
    ]
}

