resource "aws_elasticache_subnet_group" "memcached_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_group_ids
}

resource "aws_elasticache_cluster" "memcached_cluster" {
  cluster_id           = var.cluster_id
  engine               = "memcached"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = var.subnet_group_name
  port                 = var.port
  security_group_ids   = var.security_group_ids

  # Maintenance
  apply_immediately  = var.apply_immediately
  maintenance_window = var.maintenance_window

  # Tags
  tags = {
    Name        = var.cluster_id
    Region      = var.region
    Environment = var.environment
    Service     = var.supported_service
    App         = var.supported_app
  }

  depends_on = [
    aws_elasticache_subnet_group.memcached_subnet_group
  ]
}
