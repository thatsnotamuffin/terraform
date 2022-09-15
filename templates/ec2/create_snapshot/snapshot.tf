terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/snapshots/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "snapshot_create" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/create_snapshot?ref=<relevant tag>"

    target_vol      = "vol-000aaa111bbb"
    vol_description = "My Target Vol"
    snap_name       = "mytargetvol"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "MyService"
}

