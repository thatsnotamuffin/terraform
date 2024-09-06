# terraform {
#   backend "s3" {
#     bucket         = "thatsnotamuffin-pre-prod"
#     key            = "global/iam/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     kms_key_id     = "alias/terraform-pre-prod"
#     dynamodb_table = "terraform-pre-prod"
#   }
# }
