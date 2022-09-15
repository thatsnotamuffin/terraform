terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "kms/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ebs_volumes" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//kms?ref=<relevant tag>"

    target_region               = "us-east-1"

    kms_key_settings = {
        description             = "This key is used to encrypt ebs-volumes"
        deletion_window_days    = 10
        enable_rotation         = true
        alias                   = "alias/ebs-volumes"
    }
}

