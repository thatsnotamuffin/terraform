##-- This module takes snapshots of a target RDS instance --##

resource "aws_db_snapshot" "rds_snapshot" {
    db_instance_identifier = var.db_instance
    db_snapshot_identifier = var.snap_name

    tags = {
        Name        = var.snap_name
        Region      = var.target_region
        Env         = var.target_env
        App         = var.target_app
        Service     = var.target_service
    }
}

