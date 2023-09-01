terraform {
  backend "s3" {
    bucket         = "terraform-prod"
    key            = "global/ami/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/terraform-prod"
    dynamodb_table = "terraform-prod"
  }
}
