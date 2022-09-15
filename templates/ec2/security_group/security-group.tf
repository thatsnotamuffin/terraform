terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/security-group/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "security_group" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/security_group?ref=<relevant tag>"

    security_group_settings = {
        name            = "my-security-group"
        description     = "My Security Group"
        vpc_id          = "vpc-0c4cdd97e91e2f44e"
        target_region   = "us-east-1"
        target_env      = "Stage"
        target_app      = "MyApp"
        target_service  = "MyService"
    }

    ingress_rules = {
        https = {
            description         = "HTTPS to WWW"
            from_port           = 443
            to_port             = 443
            protocol            = "TCP"
            ipv4_cidr_blocks    = ["0.0.0.0/0"]
        },
        http = {
            description         = "HTTP to WWW"
            from_port           = 80
            to_port             = 80
            protocol            = "TCP"
            ipv4_cidr_blocks    = ["0.0.0.0/0"]
        },
    }

    egress_rules = {
        all = {
            description         = "Allow ALL Out"
            from_port           = 0
            to_port             = 0
            protocol            = "-1"
            ipv4_cidr_blocks    = ["0.0.0.0/0"]
            ipv6_cidr_blocks    = ["::/0"]
        },
    }

}

