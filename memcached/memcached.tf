##-- Memcached --##
#- This will create an Elasticache subnet group and a Memcached cluster -#

resource "aws_elasticache_subnet_group" "k8s_memcached_subnet_group" {
    name                        = var.memcached.subnet_group_name
    subnet_ids                  = var.db_subnets
}


# K8s Memcached
resource "aws_elasticache_cluster" "k8s_memcached" {
    cluster_id                  = var.memcached.cluster_id
    engine                      = "memcached"
    node_type                   = var.memcached.node_type
    num_cache_nodes             = var.memcached.num_cache_nodes
    parameter_group_name        = var.memcached.parameter_group_name
    subnet_group_name           = var.memcached.subnet_group_name
    port                        = var.memcached.port
    security_group_ids          = var.target_security_groups

    tags = {
        Name                    = var.memcached.cluster_id
        Region                  = var.memcached.target_region
        Env                     = var.memcached.target_env
        App                     = "N/A"
        Service                 = "memcached"
    }

    depends_on = [
      aws_elasticache_subnet_group.k8s_memcached_subnet_group
    ]
}
