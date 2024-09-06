module "dev_bucket" {
  source = "../modules/create-bucket"

  # Tags
  purpose     = "Serves Dev resources"
  environment = local.environment

  bucket        = "thatsnotamuffin-dev-resources"
  force_destroy = local.force_destroy
}

module "dev_bucket_access" {
  source = "../modules/access-settings"

  bucket                  = "thatsnotamuffin-dev-resources"
  acl                     = "private"
  object_ownership        = "BucketOwnerPreferred"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  status                  = "Disabled"
}
