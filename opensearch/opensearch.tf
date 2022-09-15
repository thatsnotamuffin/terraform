##-- OpenSearch --##
# https://registry.terraform.io/providers/PixarV/ritt/latest/docs/resources/opensearch_domain
resource "aws_opensearch_domain" "opensearch_domain" {
    domain_name         = var.target_domain
    engine_version      = var.engine_version

    cluster_config {
        instance_type   = var.instance_type
    }

    tags = {
      Name      = var.target_domain
      Region    = var.target_region
      Env       = var.target_env
      App       = var.target_app
    }
}

