terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "rds/db_subnets/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "rds_subnet_group" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//rds/db_subnet?ref=<relevant tag>"

    db_subnets                  = ["subnet-abc123def000", "subnet-abc123def111"]    

    rds_subnet_group_settings = {
        subnet_group_name       = "mydb-subnet-group"
        target_region           = "us-east-1"
        target_env              = "Stage"
        target_service          = "MyService"
    }
}

