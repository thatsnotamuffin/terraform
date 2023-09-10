locals {
  # Tags
  region      = "us-east-1"
  environment = "Pre-Production"
  env         = "pre-prod"

  # General
  kms_key_id     = "arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff"
  iops           = 3000
  throughput     = 125
  final_snapshot = false
}
