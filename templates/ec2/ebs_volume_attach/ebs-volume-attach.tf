terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/ebs-volume-attach/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vol_attach" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_attach?ref=<relevant tag>"

    device_name             = "/dev/xvdb"
    target_volume           = "vol-000aaa111bbb"
    target_instance         = "i-000aaa111bbb"

    volume_force_detach     = false
    skip_destroy            = true
    stop_instance_detach    = true
}

