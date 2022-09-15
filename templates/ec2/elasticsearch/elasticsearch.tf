terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/elasticsearch/terraform.tfstate"
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
module "data_vol_snapshot_1" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/create_snapshot?ref=<relevant tag>"

    target_vol      = "vol-000aaa111bbb"
    vol_description = "example migration myapp data volume 1 snapshot"
    snap_name       = "example-migration-data-vol-1"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "Elasticsearch"
}

module "data_vol_snapshot_2" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/create_snapshot?ref=<relevant tag>"

    target_vol      = "vol-222ccc333ddd"
    vol_description = "example migration myapp data volume 2 snapshot"
    snap_name       = "example-migration-data-vol-2"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "Elasticsearch"
}

module "data_vol_snapshot_3" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/create_snapshot?ref=<relevant tag>"

    target_vol      = "vol-444eee555fff"
    vol_description = "example migration myapp data volume 3 snapshot"
    snap_name       = "example-migration-data-vol-3"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "Elasticsearch"
}

#- Data Volumes
module "data_volume_1" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_create?ref=<relevant tag>"

    target_zone     = "us-east-1e"
    target_snapshot = module.data_vol_snapshot_1.snapshot_id
    vol_name        = "data-vol-es-1-example"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "Elasticsearch"
    kms_key         = "arn:aws:kms:us-east-1:000aaa111bbbc:key/0123abcd"

    depends_on = [
      module.data_vol_snapshot_1
    ]
}

module "data_volume_2" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_create?ref=<relevant tag>"

    target_zone     = "us-east-1b"
    target_snapshot = module.data_vol_snapshot_2.snapshot_id
    vol_name        = "data-vol-es-2-example"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "Elasticsearch"
    kms_key         = "arn:aws:kms:us-east-1:000aaa111bbbc:key/0123abcd"

    depends_on = [
      module.data_vol_snapshot_2
    ]
}

module "data_volume_3" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_create?ref=<relevant tag>"

    target_zone     = "us-east-1c"
    target_snapshot = module.data_vol_snapshot_3.snapshot_id
    vol_name        = "data-vol-es-3-example"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "MyApp"
    target_service  = "Elasticsearch"
    kms_key         = "arn:aws:kms:us-east-1:000aaa111bbbc:key/0123abcd"

    depends_on = [
      module.data_vol_snapshot_3
    ]
}

#- Instances
module "elasticsearch_cluster" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/elasticsearch?ref=<relevant tag>"

    #- EC2 Settings
    # General Settings
    cluster_count                   = 3
    target_region                   = "us-east-1"
    target_env                      = "Stage"

    # Networking and Security
    target_vpc                      = "vpc-000aaa111bbb"
    db_subnets                      = ["subnet-abc123def000", "subnet-abc123def111", "subnet-abc123def222"]
    target_security_groups          = ["sg-000aaa111bbb", "sg-222ccc333ddd"]

    # EC2 Instance Settings
    general_instance_settings = {
        global_ami                  = "ami-000aaa111bbb"
        vol_type                    = "gp3"
        root_vol_size               = 50
        encrypted_volume            = true
        ssh_key                     = "my-ssh-key"
        kms_key                     = "arn:aws:kms:us-east-1:000aaa111bbbc:key/0123abcd"
    }

    elasticsearch_settings = {
        elasticsearch_instance_type = "t3.medium"
        target_app                  = "MyApp"
        target_version              = "5.5"
        cluster_name                = "es-example"
        cluster_description         = "es-cluster-example"
        instance_role               = "es-role-example"
    }

    # Data Volume settings
    data_vol_ids                    = [module.data_volume_1.ebs_volume_id, module.data_volume_2.ebs_volume_id, module.data_volume_3.ebs_volume_id]
    data_vol_destroy                = false


    elasticsearch_instance_names    = ["es-1-example", "es-2-example", "es-3-example"]
    elasticsearch_hostnames         = ["es-1.example.com", "es-2.example.com", "es-3.example.com"]

    # Target Group
    elasticsearch_tg_settings = {
        elastic_target_type         = "instance"
        elastic_tg_name             = "es-example-tg"
        port                        = 80
        protocol                    = "HTTP"
    }

    # Load Balancer and Listener
    elastic_lb_settings = {
        lb_name                     = "es-example"
        internal                    = true
        loadbalancer_type           = "application"
        deletion_protection         = false
    }

    elastic_https_listener = {
        port                        = 443
        protocol                    = "HTTPS"
        ssl                         = "ELBSecurityPolicy-FS-1-2-2019-08"
        cert_arn                    = "arn:aws:acm:us-east-1:000aaa111bbb:certificate/000aaa111ccc"
        default_action_type         = "forward"
        listener_name               = "es-example-https"
    }

    # Route53 - DNS
    elastic_record = {
        zone_id                     = "000aaa111bbb"
        dns_name                    = "es.example.com"
        cluster_record_type         = "A"
        ttl                         = 300
        instance_record_type        = "A"
    }
}

