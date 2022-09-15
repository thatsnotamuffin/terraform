terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/ebs-volume-create/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "volume_create" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_create?ref=<relevant tag>"

    target_zone     = "us-east-1e"
    target_snapshot = "snap-000aaa111bbb"
    vol_name        = "my-vol-name"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "MyService"
    kms_key         = "arn:aws:kms:us-east-1:000aaa111bbbc:key/0123abcd"
}

