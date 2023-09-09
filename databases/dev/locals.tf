locals {
  # Tags
  region            = "us-east-1"
  environment       = "Dev"
  supported_app     = "My App"
  supported_service = "My Service"

  # Networking
  db_subnets = ["subnet-111222333", "subnet-444555666"]

  # Security
  security_group_ids = ["sg-111222333", "sg-444555666"]

  # RDS
  rds_parameter_group        = "default.postgres13"
  rds_kms_key                = "arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff"
  rds_subnet_group_name      = "thatsnotamuffin-dev-subnet-group"
  maintenance_window         = "sat:06:00-sat:08:00"
  backup_window              = "22:00-00:00"
  postgres_supported_service = "postgres"
}
