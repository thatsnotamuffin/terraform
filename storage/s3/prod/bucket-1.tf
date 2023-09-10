module "prod_bucket" {
  source = "../modules/create-bucket"

  # Tags
  purpose     = "Serves Production resources"
  environment = local.environment

  bucket        = "thatsnotamuffin-prod-resources"
  force_destroy = local.force_destroy
}

module "prod_bucket_access" {
  source = "../modules/access-settings"

  bucket                  = "thatsnotamuffin-prod-resources"
  acl                     = "private"
  object_ownership        = "BucketOwnerPreferred"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  status                  = "Disabled"
}
