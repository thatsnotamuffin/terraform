terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "rds/snapshots/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "rds_snapshot" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//rds/rds_snapshot?ref=<relevant tag>"

    db_instance     = "my-db-identifier"
    snap_name       = "mysnapname"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "MyService"
}

