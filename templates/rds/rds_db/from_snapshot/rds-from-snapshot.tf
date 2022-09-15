terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "rds/from_snapshot/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "rds_from_snapshot" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//rds/rds_db/from_snapshot?ref=<relevant tag>"

    # Networking
    db_subnets                      = ["subnet-abc123def000", "subnet-abc123def111"]

    # Security
    target_security_groups          = ["sg-abc000def111", "sg-abc000def222", "sg-abc000def333"]

    postgres_settings = {
        db_snapshot                 = "my-db-source-snapshot"
        db_identifier               = "mydb-identifier"
        db_instance_class           = "db.m6g.large"
        skip_final_snapshot         = true
        allow_major_version_upgrade = true
        auto_minor_upgrade          = true
        backup_retention            = 7
        backup_window               = "04:00-05:00"
        maintenance_window          = "sat:06:00-sat:08:00"
        snapshot_tags               = true
        rds_subnet_group_name       = "mydb-subnet-group"
        delete_protection           = false
        final_snapshot_identifier   = "mydb-final"
        iam_auth_enabled            = false
        encrypted_storage           = true
        kms_key                     = "arn:aws:kms:us-east-1:1111111111111:key/abc123cd"
        storage_type                = "gp2"
        target_region               = "us-east-1"
        target_env                  = "Stage"
        target_app                  = "MyApp"
        target_service              = "MyService"
    }
}

