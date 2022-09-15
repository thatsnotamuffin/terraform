terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/nginx/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "nginx" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/nginx?ref=<relevant tag>"

    security_group_name             = "allow-web-traffic"

    #- EC2 Settings
    # General Settings
    nginx_count                     = 2
    target_region                   = "us-east-1"
    target_env                      = "Stage"

    # Security
    target_security_groups          = ["sg-000aaa111bbb", "sg-222ccc333ddd", "sg-444eee555fff"]

    # Networking
    target_vpc                      = "vpc-000aaa111bbb"
    web_subnets                     = ["subnet-000aaa111bbb", "subnet-222ccc333ddd"]

    # EC2 Instance Settings
    general_instance_settings = {
        global_ami                  = "ami-000aaa111bbb"
        encrypted_volume            = true
        vol_type                    = "gp3"
        root_vol_size               = 50
        ssh_key                     = "my-ssh-key"
        kms_key                     = "arn:aws:kms:us-east-1:111222333444:key/1234abcd"
    }

    nginx_instance_type             = "t2.small"

    # Hostnames
    nginx_instance_names            = ["nginx-1", "nginx-2"]

    #- Target Group
    nginx_tg_settings = {
        nginx_target_type           = "instance"
        nginx_tg_name               = "nginx-tg"
        port                        = 80
        protocol                    = "HTTP"
    }

    #- Load Balancer
    nginx_lb_settings = {
        lb_name                     = "nginx-alb"
        internal                    = false
        loadbalancer_type           = "application"
        deletion_protection         = false
    }

    #- Listeners
    # HTTPS
    nginx_https_listener = {
        port                        = "443"
        protocol                    = "HTTPS"
        ssl_policy                  = "ELBSecurityPolicy-FS-1-2-2019-08"
        certificate_arn             = "arn:aws:acm:us-east-1:000111222333:certificate/0123abcd"
        default_action_type         = "forward"
        listener_name               = "nginx-https"
    }

    # HTTP
    nginx_http_listener = {
        port                        = "80"
        protocol                    = "HTTP"
        default_action_type         = "forward"
        listener_name               = "nginx-http"
    }

    #- Route53 - DNS
    # Base Domain
    r53_base_domain = {
        zone_id                     = "0123abcd"
        name                        = "example.com"
        type                        = "A"
    }

    r53_wildcard_base_domain = {
        zone_id                     = "0123abcd"
        name                        = "*.example.com"
        type                        = "A"
    }
}

