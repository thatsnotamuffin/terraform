##-- NGINX EC2 Instance Configuration --##

# Creates a set of NGINX instances - an associated application load balancer - and route53 entries

# Create security group
resource "aws_security_group" "allow_web" {
  name        = var.nginx_web_security_group_name
  description = "Allow HTTP and HTTPS inbound traffic"

  vpc_id = var.web_vpc

  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "IPv4 HTTPS"
    from_port        = 443
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "TCP"
    self             = false
    to_port          = 443
  }

  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "IPv4 HTTP"
    from_port        = 80
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "TCP"
    self             = false
    to_port          = 80
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = var.nginx_web_security_group_name
    Region      = var.region
    Environment = var.environment
    Managed_By  = "Terraform"
  }
}

# Combine security groups with the created web security group in order to be deployed on the NGINX ALB
locals {
  all_security_groups = setunion(
    var.web_security_groups, [aws_security_group.allow_web.id]
  )
}

#- EC2 Instance
resource "aws_instance" "ec2_nginx" {
  count = var.nginx_count

  # General Instance Info
  ami           = var.nginx_ami
  instance_type = var.nginx_instance_type

  # Block Device - Root
  root_block_device {
    volume_type = "gp3"
    volume_size = var.nginx_root_vol_size
    encrypted   = true
    kms_key_id  = var.ebs_kms_key

    tags = {
      Name        = "nginx-root-vol-${count.index + 1}-${var.domain_environment}"
      Region      = var.region
      Environment = var.environment
      Service     = "NGINX"
      App         = "N/A"
      Managed_By  = "Terraform"
    }
  }

  vpc_security_group_ids = var.web_security_groups
  subnet_id              = var.web_subnets[count.index]
  key_name               = var.ssh_key

  tags = {
    Name        = var.nginx_instance_names[count.index]
    Region      = var.region
    Environment = var.environment
    Service     = "NGINX"
    App         = "N/A"
    Managed_By  = "Terraform"
  }
}

# Attach created web security group
resource "aws_network_interface_sg_attachment" "web_attachment" {
  count             = var.nginx_count
  security_group_id = aws_security_group.allow_web.id

  network_interface_id = aws_instance.ec2_nginx[count.index].primary_network_interface_id

  depends_on = [
    aws_instance.ec2_nginx
  ]
}

# Target Group
resource "aws_lb_target_group" "nginx_tg" {
  target_type = "instance"
  name        = var.nginx_tg_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.web_vpc

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
    Name        = var.nginx_tg_name
    Region      = var.region
    Environment = var.environment
    Service     = "NGINX"
    App         = "N/A"
    Managed_By  = "Terraform"
  }

  depends_on = [
    aws_instance.ec2_nginx
  ]
}

resource "aws_lb_target_group_attachment" "nginx_tg_attach" {
  count            = var.nginx_count
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = aws_instance.ec2_nginx[count.index].id
  port             = 80

  depends_on = [
    aws_lb_target_group.nginx_tg
  ]
}

# Loadbalancer and Listener
resource "aws_lb" "nginx_alb" {
  name                       = var.nginx_lb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = local.all_security_groups
  subnets                    = var.web_subnets
  enable_deletion_protection = var.nginx_enable_deletion_protection

  access_logs {
    enabled = var.nginx_lb_access_logs_enabled
    bucket  = var.alb_logs_bucket
  }

  tags = {
    Name        = var.nginx_lb_name
    Region      = var.region
    Environment = var.environment
    Service     = "NGINX"
    App         = "N/A"
    Managed_By  = "Terraform"
  }

  depends_on = [
    aws_lb_target_group_attachment.nginx_tg_attach
  ]
}

resource "aws_lb_listener" "nginx_listener_https" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.nginx_ssl_policy
  certificate_arn   = var.nginx_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }

  tags = {
    Name        = var.nginx_https_listener_name
    Region      = var.region
    Environment = var.environment
    Service     = "NGINX"
    App         = "N/A"
    Managed_By  = "Terraform"
  }

  depends_on = [
    aws_lb.nginx_alb
  ]
}

resource "aws_lb_listener" "nginx_listener_http" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }

  tags = {
    Name        = var.nginx_http_listener_name
    Region      = var.region
    Environment = var.environment
    Service     = "NGINX"
    App         = "N/A"
    Managed_By  = "Terraform"
  }

  depends_on = [
    aws_lb.nginx_alb
  ]
}

# Route53
resource "aws_route53_record" "wildcard_domain" {
  zone_id = var.nginx_zone_id
  name    = var.nginx_route53_name
  type    = "A"

  alias {
    name                   = aws_lb.nginx_alb.dns_name
    zone_id                = aws_lb.nginx_alb.zone_id
    evaluate_target_health = true
  }

  depends_on = [
    aws_lb.nginx_alb
  ]
}

resource "aws_route53_record" "instance_records" {
  count   = length(aws_instance.ec2_nginx)
  zone_id = var.nginx_zone_id
  ttl     = 60
  type    = "A"
  name    = var.nginx_hostnames[count.index]
  records = [aws_instance.ec2_nginx[count.index].private_ip]
}
