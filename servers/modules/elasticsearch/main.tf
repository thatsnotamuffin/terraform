resource "aws_instance" "elasticsearch_instance" {
  count = var.cluster_count

  ami           = var.ami
  instance_type = var.instance_type

  # Block Device - Root
  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
    encrypted   = true
    kms_key_id  = var.kms_key_id

    tags = {
      Name        = "root-vol-${var.instance_names[count.index]}"
      Region      = var.region
      Environment = var.environment
      Service     = var.supported_service
      App         = var.supported_app
      Managed_By  = "Terraform"
    }
  }

  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnets[count.index]
  key_name               = var.ssh_key

  tags = {
    Name             = var.instance_names[count.index]
    Region           = var.region
    Environment      = var.environment
    Service          = var.supported_service
    App              = var.supported_app
    "es:clusterName" = var.cluster_name
    "es:description" = var.cluster_description
    Hostname         = var.hostnames[count.index]
    Managed_By       = "Terraform"
  }
}

resource "aws_volume_attachment" "data_volumes" {
  count = var.cluster_count

  device_name  = "/dev/xvdb"
  volume_id    = var.data_vol_ids[count.index]
  instance_id  = aws_instance.elasticsearch_instance[count.index].id
  skip_destroy = var.data_vol_destroy

  depends_on = [
    aws_instance.elasticsearch_instance
  ]
}

# Target Group
resource "aws_lb_target_group" "es_tg" {
  target_type = "instance"
  name        = var.tg_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    interval            = 30
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher             = "200"
  }

  tags = {
    Name        = var.tg_name
    Region      = var.region
    Environment = var.environment
    Service     = var.supported_service
    App         = var.supported_app
    Managed_By  = "Terraform"
  }

  depends_on = [
    aws_instance.elasticsearch_instance
  ]
}

resource "aws_lb_target_group_attachment" "tg_attach" {
  count            = var.cluster_count
  target_group_arn = aws_lb_target_group.es_tg.arn
  target_id        = aws_instance.elasticsearch_instance[count.index].id
  port             = 80

  depends_on = [
    aws_lb_target_group.es_tg
  ]
}

# Loadbalancer and Listener
resource "aws_lb" "es_lb" {
  name                       = var.lb_name
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = var.vpc_security_group_ids
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection

  access_logs {
    enabled = var.access_logs_enabled
    bucket  = var.access_logs_bucket
  }

  tags = {
    Name        = var.lb_name
    Region      = var.region
    Environment = var.environment
    Service     = var.supported_service
    App         = var.supported_app
    Managed_By  = "Terraform"
  }
}

resource "aws_lb_listener" "es_listener" {
  load_balancer_arn = aws_lb.es_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.es_tg.arn
  }

  tags = {
    Name        = var.es_listener_name
    Region      = var.region
    Environment = var.environment
    Service     = var.supported_service
    App         = var.supported_app
    Managed_By  = "Terraform"
  }

  depends_on = [
    aws_lb.es_lb
  ]
}

# Route53
resource "aws_route53_record" "cluster_record" {
  zone_id = var.zone_id
  name    = var.cluster_dns_name
  type    = "A"

  alias {
    name                   = aws_lb.es_lb.dns_name
    zone_id                = aws_lb.es_lb.zone_id
    evaluate_target_health = true
  }

  depends_on = [
    aws_lb.es_lb
  ]
}

resource "aws_route53_record" "instance_records" {
  count   = length(aws_instance.elasticsearch_instance)
  zone_id = var.zone_id
  ttl     = 300
  name    = var.hostnames[count.index]
  type    = "A"
  records = [aws_instance.elasticsearch_instance[count.index].private_ip]

  depends_on = [
    aws_instance.elasticsearch_instance
  ]
}
