terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "dynamodb/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vault_dynamodb" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//dynamodb?ref=<relevant tag>"

    dynamodb_settings = {
        table_name      = "mytable"
        billing_mode    = "PROVISIONED"
        read_cap        = 15
        write_cap       = 15
        hash            = "Path"
        hash_type       = "S"
        range           = "Key"
        range_type      = "S"
        kms_key         = "arn:aws:kms:us-east-1:111222333:key/000aaa111bbb"
        target_region   = "us-east-1"
        target_env      = "Stage"
        target_app      = "MyApp"
        target_service  = "Kubernetes"
    }
}
