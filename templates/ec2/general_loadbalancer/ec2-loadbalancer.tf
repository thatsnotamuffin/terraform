terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/general-loadbalancer/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

#- Snapshots 
module "general_lb" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/general_loadbalancer?ref=<relevant tag>"

    instance_count          = 2
    target_vpc              = "vpc-000aaa111bbb"
    instance_port           = 80
    target_instances        = ["i-000aaa111bbb","i-222ccc333ddd"]
    target_subnets          = ["subnet-000aaa111bbb","subnet-222ccc333ddd"]
    target_security_groups  = ["sg-000aaa111bbb","sg-222ccc333ddd"]

    target_region           = "us-east-1"
    target_env              = "Stage"
    target_app              = "MyApp"
    target_service          = "MyService"

    target_group_settings = {
        target_group_type   = "instance"
        target_group_name   = "my-target-group"
        port                = 80
        protocol            = "HTTP"
        path                = "/"
        health_port         = 80
        health_protocol     = "HTTP"
        health_interval     = 5
        healthy_threshold   = 3
        unhealthy_threshold = 1
        health_matcher      = "200"
    }

    lb_settings = {
        lb_name             = "my-lb"
        internal            = false
        load_balancer_type  = "application"
        deletion_protection = false
    }

    listener_settings = {
        port                = "80"
        protocol            = "HTTP"
        ssl                 = "ELBSecurityPolicy-2016-08"
        cert_arn            = "arn:aws:iam:000111222333:server-certificate/000aaa111bbb"
        default_action_type = "forward"
        listener_name       = "my-lb-listener"
    }

}

