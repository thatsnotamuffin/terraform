##-- This module creates snapshots from EC2 volumes --##

resource "aws_ebs_snapshot" "ebs_snapshot" {
    volume_id       = var.target_vol
    description     = var.vol_description

    tags = {
        Name        = var.snap_name
        Origin      = var.target_vol
        Region      = var.target_region
        Env         = var.target_env
        App         = var.target_app
        Service     = var.target_service
    }
}

