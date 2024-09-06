module "subnet_group" {
  source = "../modules/rds/db-subnet"

  # Tags
  region      = local.region
  environment = local.environment

  subnet_group_name = local.rds_subnet_group_name
  subnet_ids        = local.db_subnets
}
