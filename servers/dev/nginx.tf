module "nginx_servers" {
  source = "../modules/nginx"

  # Tags
  region             = local.region
  environment        = local.environment
  domain_environment = local.domain_environment

  # General Instance Settings
  nginx_count          = 1
  nginx_instance_names = ["nginx-1-dev"]
  nginx_ami            = local.ami
  nginx_instance_type  = "t3.small"
  ssh_key              = local.ssh_key

  # Storage Settings
  nginx_root_vol_size = 50
  ebs_kms_key         = local.kms_key_id

  # Networking
  nginx_ssl_policy                 = local.ssl_policy
  nginx_web_security_group_name    = "nginx-${local.domain_environment}-allow-web"
  web_security_groups              = local.web_security_groups
  web_subnets                      = local.web_subnets
  nginx_tg_name                    = "nginx-${local.domain_environment}-tg"
  web_vpc                          = local.web_vpc
  nginx_lb_name                    = "nginx-${local.domain_environment}-alb"
  nginx_lb_access_logs_enabled     = true
  alb_logs_bucket                  = local.alb_logs_bucket
  nginx_https_listener_name        = "nginx-${local.domain_environment}-https"
  nginx_http_listener_name         = "nginx-${local.domain_environment}-http"
  nginx_cert_arn                   = local.cert_arn
  nginx_enable_deletion_protection = local.alb_enable_deletion_protection

  # Route53
  nginx_zone_id      = local.zone_id
  nginx_route53_name = "*.${local.domain_environment}.com"
  nginx_hostnames    = ["nginx-1.${local.domain_environment}.com"]
}
