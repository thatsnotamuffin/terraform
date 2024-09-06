module "dynamodb" {
  source = "../modules/dynamodb"

  # Tags
  region            = local.region
  environment       = local.environment
  supported_app     = local.supported_app
  supported_service = local.supported_service

  # Table Settings
  table_name    = "prod-dynamodb"
  table_kms_key = "arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff"
}
