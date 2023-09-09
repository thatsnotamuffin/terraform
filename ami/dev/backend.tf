# terraform {
#   backend "s3" {
#     bucket         = "thatsnotamuffin-dev"
#     key            = "global/ami/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     kms_key_id     = "alias/terraform-dev"
#     dynamodb_table = "terraform-dev"
#   }
# }
