##-- EC2 Instances Elasticsearch --##
# This covers the Elasticsearch clusters for the Arugula - Kale - Turnip apps - this will need to be ran for each cluster

#- EC2 Instance
resource "aws_instance" "elasticsearch_instances" {
  count                     = var.cluster_count
  # General Instance Info
  ami                       = var.general_instance_settings.global_ami
  instance_type             = var.elasticsearch_settings.elasticsearch_instance_type
  key_name                  = var.general_instance_settings.ssh_key

  # Block Devices
  # Root volume
  root_block_device {
    volume_type             = var.general_instance_settings.vol_type
    volume_size             = var.general_instance_settings.root_vol_size
    encrypted               = var.general_instance_settings.encrypted_volume
    kms_key_id              = var.general_instance_settings.kms_key

    tags = {
      Name                  = "root-vol-${var.elasticsearch_instance_names[count.index]}"
      Region                = var.target_region
      Env                   = var.target_env
      Service               = var.elasticsearch_settings.target_version
      App                   = var.elasticsearch_settings.target_app
    }
  }

  # Security Groups
  vpc_security_group_ids    = var.target_security_groups

  # Networking
  subnet_id                 = var.db_subnets[count.index]

  # Instance Profile
  iam_instance_profile      = var.elasticsearch_settings.instance_role

  tags = {
    Name                    = var.elasticsearch_instance_names[count.index]
    Region                  = var.target_region
    Env                     = var.target_env
    Service                 = "Elasticsearch ${var.elasticsearch_settings.target_version}"
    App                     = var.elasticsearch_settings.target_app
    "es:clusterName"        = var.elasticsearch_settings.cluster_name
    "es:description"        = var.elasticsearch_settings.cluster_description
    hostname                = var.elasticsearch_hostnames[count.index]
  }
}

#- Volume Attachment
resource "aws_volume_attachment" "elasticsearch_data_volume" {
  count                     = var.cluster_count

  device_name               = "/dev/xvdb"
  volume_id                 = var.data_vol_ids[count.index]
  instance_id               = aws_instance.elasticsearch_instances[count.index].id
  skip_destroy              = var.data_vol_destroy

  depends_on = [
    aws_instance.elasticsearch_instances
  ]
}

#- Target Group
resource "aws_lb_target_group" "elasticsearch_tg" {
    target_type             = var.elasticsearch_tg_settings.elastic_target_type
    name                    = var.elasticsearch_tg_settings.elastic_tg_name
    port                    = var.elasticsearch_tg_settings.port
    protocol                = var.elasticsearch_tg_settings.protocol
    vpc_id                  = var.target_vpc

    health_check {
        path                = "/"
        port                = var.elasticsearch_tg_settings.port
        protocol            = var.elasticsearch_tg_settings.protocol
        interval            = 30
        healthy_threshold   = 5
        unhealthy_threshold = 5
        matcher             = "200"
    }

    depends_on = [
      aws_instance.elasticsearch_instances
    ]
}

resource "aws_lb_target_group_attachment" "elasticsearch_tg_attach" {
    count                   = var.cluster_count
    target_group_arn        = aws_lb_target_group.elasticsearch_tg.arn
    target_id               = aws_instance.elasticsearch_instances[count.index].id
    port                    = 80
}

#- Load Balancer and Listeners
resource "aws_lb" "elastic_alb" {
  name                        = var.elastic_lb_settings.lb_name
  internal                    = var.elastic_lb_settings.internal
  load_balancer_type          = var.elastic_lb_settings.loadbalancer_type
  security_groups             = var.target_security_groups
  subnets                     = var.db_subnets
  enable_deletion_protection  = var.elastic_lb_settings.deletion_protection

  tags = {
    Name                      = var.elastic_lb_settings.lb_name
    Region                    = var.target_region
    Env                       = var.target_env
    App                       = var.elasticsearch_settings.target_app
    Service                   = "Elasticsearch ${var.elasticsearch_settings.target_version}"
  }

  depends_on = [
    aws_lb_target_group_attachment.elasticsearch_tg_attach
  ]
}

resource "aws_lb_listener" "elastic_listener" {
  load_balancer_arn     = aws_lb.elastic_alb.arn
  port                  = var.elastic_https_listener.port
  protocol              = var.elastic_https_listener.protocol
  ssl_policy            = var.elastic_https_listener.ssl
  certificate_arn       = var.elastic_https_listener.cert_arn

  default_action {
    type                = var.elastic_https_listener.default_action_type
    target_group_arn    = aws_lb_target_group.elasticsearch_tg.arn
  }

  tags = {
    Name                = var.elastic_https_listener.listener_name
    Region              = var.target_region
    Env                 = var.target_env
    App                 = var.elasticsearch_settings.target_app
    Service             = "Elasticsearch ${var.elasticsearch_settings.target_version}"
  }
}

#- Route53 - DNS
resource "aws_route53_record" "cluster_record" {
  zone_id                   = var.elastic_record.zone_id
  name                      = var.elastic_record.dns_name
  type                      = var.elastic_record.cluster_record_type

  alias {
    name                    = aws_lb.elastic_alb.dns_name
    zone_id                 = aws_lb.elastic_alb.zone_id
    evaluate_target_health  = true
  }
}

resource "aws_route53_record" "instance_records" {
  count                     = length(aws_instance.elasticsearch_instances)
  zone_id                   = var.elastic_record.zone_id
  ttl                       = var.elastic_record.ttl
  name                      = var.elasticsearch_hostnames[count.index]
  type                      = var.elastic_record.instance_record_type
  records                   = [aws_instance.elasticsearch_instances[count.index].private_ip]
}

