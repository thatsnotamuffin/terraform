module "memcached_cluster" {
  source = "../modules/memcached"

  # Tags
  region            = local.region
  environment       = local.environment
  supported_service = local.supported_service
  supported_app     = local.supported_app

  # Subnet Group
  subnet_group_name = "thatsnotamuffin-subnet-group"
  subnet_group_ids  = local.db_subnets

  cluster_id           = "thatsnotamuffin-cluster"
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.6"
  security_group_ids   = local.security_group_ids

  apply_immediately  = true
  maintenance_window = "sun:05:00-sun:09:00"
}
