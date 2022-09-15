terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "opensearch/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "opensearch" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//opensearch?ref=<relevant tag>"

    target_domain   = "mydomain"
    engine_version  = "OpenSearch_1.0"
    instance_type   = "r4.larget.search"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
}

