module "elasticsearch_servers" {
  source = "../modules/elasticsearch"

  # Tags
  region              = local.region
  environment         = local.environment
  supported_service   = "Elasticsearch 7.1"
  supported_app       = "My App"
  cluster_name        = "thatsnotamuffin-es-cluster-${local.domain_environment}"
  cluster_description = "thatsnotamuffin-es-cluster${local.domain_environment}"

  # General Instance Settings
  cluster_count  = 3
  ami            = local.ami
  instance_type  = "t3.medium"
  ssh_key        = local.ssh_key
  instance_names = ["thatsnotamuffin-es-1-${local.domain_environment}", "thatsnotamuffin-es-2-${local.domain_environment}", "thatsnotamuffin-es-3-${local.domain_environment}"]

  # Storage Settings
  volume_size      = 100
  kms_key_id       = local.kms_key_id
  data_vol_ids     = [data.aws_ebs_volume.es_vol_1.id, data.aws_ebs_volume.es_vol_2.id, data.aws_ebs_volume.es_vol_3.id]
  data_vol_destroy = false

  # Networking
  ssl_policy                 = local.ssl_policy
  tg_name                    = "thatsnotamuffin-es-${local.domain_environment}-tg"
  lb_name                    = "thatsnotamuffin-es-${local.domain_environment}"
  access_logs_bucket         = local.alb_logs_bucket
  access_logs_enabled        = true
  certificate_arn            = local.cert_arn
  es_listener_name           = "thatsnotamuffin-es-${local.domain_environment}-https"
  enable_deletion_protection = true

  vpc_id                 = local.db_vpc
  subnets                = local.db_subnets
  vpc_security_group_ids = local.db_security_groups

  # Route53
  hostnames        = ["thatsnotamuffin-es-1.myurl.com", "thatsnotamuffin-es-2.myurl.com", "thatsnotamuffin-es-3.myurl.com"]
  zone_id          = local.zone_id
  cluster_dns_name = "thatsnotamuffin-es-cluster.myurl.com"
}
