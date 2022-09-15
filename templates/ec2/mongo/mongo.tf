terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/mongo/terraform.tfstate"
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
    vol_description = "data volume 1 snapshot"
    snap_name       = "data-vol-1"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "myapp"
    target_service  = "MongoDB"
}

module "data_vol_snapshot_2" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/create_snapshot?ref=<relevant tag>"

    target_vol      = "vol-222ccc333ddd"
    vol_description = "data volume 2 snapshot"
    snap_name       = "data-vol-2"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "myapp"
    target_service  = "MongoDB"
}

module "data_vol_snapshot_3" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/create_snapshot?ref=<relevant tag>"

    target_vol      = "vol-444eee555fff"
    vol_description = "data volume 3 snapshot"
    snap_name       = "data-vol-3"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "myapp"
    target_service  = "MongoDB"
}

#- Data Volumes
module "data_volume_1" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_create?ref=<relevant tag>"

    target_zone     = "us-east-1e"
    target_snapshot = module.data_vol_snapshot_1.snapshot_id
    vol_name        = "data-vol-mongo-1"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "myapp"
    target_service  = "MongoDB"
    kms_key         = "arn:aws:kms:us-east-1:111222333444:key/1234abcd"

    depends_on = [
      module.data_vol_snapshot_1
    ]
}

module "data_volume_2" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_create?ref=<relevant tag>"

    target_zone     = "us-east-1b"
    target_snapshot = module.data_vol_snapshot_2.snapshot_id
    vol_name        = "data-vol-mongo-2"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "myapp"
    target_service  = "MongoDB"
    kms_key         = "arn:aws:kms:us-east-1:111222333444:key/1234abcd"

    depends_on = [
      module.data_vol_snapshot_2
    ]
}

module "data_volume_3" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/ebs_volume_create?ref=<relevant tag>"

    target_zone     = "us-east-1c"
    target_snapshot = module.data_vol_snapshot_3.snapshot_id
    vol_name        = "data-vol-mongo-3"
    target_region   = "us-east-1"
    target_env      = "Stage"
    target_app      = "myapp"
    target_service  = "MongoDB"
    kms_key         = "arn:aws:kms:us-east-1:111222333444:key/1234abcd"

    depends_on = [
      module.data_vol_snapshot_3
    ]
}


module "mongodb_replicaset" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/mongo?ref=<relevant tag>"

    #- EC2 Settings
    # General Settings
    cluster_count                   = 2
    target_region                   = "us-east-1"
    target_env                      = "Stage"

    # Security
    target_security_groups          = ["sg-000aaa111bbb", "sg-222ccc333ddd", "sg-444eee555fff"]

    # Networking
    db_subnets                      = ["subnet-000aaa111bbb", "subnet-222ccc333ddd"]

    # EC2 Instance Settings
    general_instance_settings = {
        global_ami                  = "ami-000aaa111bbb"
        vol_type                    = "gp3"
        root_vol_size               = 50
        encrypted_volume            = true
        ssh_key                     = "my-ssh-key"
        kms_key                     = "arn:aws:kms:us-east-1:111222333444:key/1234abcd"
    }

    mongodb_settings = {
        mongo_instance_type         = "t3.large"
        target_app                  = "myapp"
        target_version              = "4.2"
        mongodb_replset             = "mongo-RS"
        mongodb_description         = "mongo-replicaset"
        instance_role               = "mongodb-role"
    }

    # Arbiter Settings
    arbiter_settings = {
        instance_type               = "t3.large"
        instance_name               = "mongodb-3"
        volume_type                 = "gp3"
        volume_size                 = 50
        encrypted_volume            = true
        kms_key_id                  = "arn:aws:kms:us-east-1:111222333444:key/1234abcd"
        subnet_id                   = "subnet-444eee555fff"
        arbiter_instance_profile    = "mongodb-role"
        ssh_key                     = "my-ssh-key"
        hostname                    = "mongodb-3.example.com"
    }

    # Data Volume settings
    data_vol_ids                    = [module.data_volume_1.ebs_volume_id, module.data_volume_2.ebs_volume_id]
    arbiter_data_vol                = module.data_volume_3.ebs_volume_id
    data_vol_destroy                = false

    mongo_instance_names            = ["mongodb-1", "mongodb-2"]
    mongo_hostnames                 = ["mongodb-1.example.com", "mongodb-2.example.com"]

    # Route53 - DNS
    mongodb_record = {
        zone_id                     = "0123abcd"
        ttl                         = 60
        record_type                 = "A"
    }
}

