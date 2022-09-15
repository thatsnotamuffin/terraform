terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "rds/fresh_db/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "rds_fresh_db" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//rds/rds_db/fresh_db?ref=<relevant tag>"

    target_security_groups          = ["sg-abc000def111", "sg-abc000def222", "sg-abc000def333"]

    postgres_settings = {
        db_identifier               = "mydb-identifier"
        allocated_storage           = 100
        db_engine                   = "mysql"
        db_engine_version           = "5.7"
        db_instance_class           = "db.m6g.large"
        db_name                     = "mydb"
        skip_final_snapshot         = false
        allow_major_version_upgrade = true
        auto_minor_upgrade          = true
        backup_rentention           = 7
        backup_window               = "04:00-05:00"
        maintenance_window          = "sat:06:00-sat:08:00"
        snapshot_tags               = "mydb-snapshot"
        rds_subnet_group_name       = "my-db-sugnet-group"
        delete_protection           = false
        final_snapshot_identifier   = "mydb-final-snapshot"
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

