module "pre_prod_bucket" {
  source = "../modules/create-bucket"

  # Tags
  purpose     = "Serves Pre-Production resources"
  environment = local.environment

  bucket        = "thatsnotamuffin-pre-prod-resources"
  force_destroy = local.force_destroy
}

module "pre_prod_bucket_access" {
  source = "../modules/access-settings"

  bucket                  = "thatsnotamuffin-pre-prod-resources"
  acl                     = "private"
  object_ownership        = "BucketOwnerPreferred"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  status                  = "Disabled"
}
