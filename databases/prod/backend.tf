# terraform {
#   backend "s3" {
#     bucket         = "thatsnotamuffin-prod"
#     key            = "databases/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     kms_key_id     = "alias/terraform-prod"
#     dynamodb_table = "terraform-prod"
#   }
# }
