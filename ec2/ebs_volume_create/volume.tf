##-- EBS Volume --##
# This module creates EBS volumes from snapshots
# This was created for the AWS migration but I'm sure it can be used for other stuff

resource "aws_ebs_volume" "ebs_volume_create" {
    availability_zone   = var.target_zone
    snapshot_id         = var.target_snapshot
    type                = "gp3"
    encrypted           = true
    kms_key_id          = var.kms_key


    tags = {
        Name            = var.vol_name
        Region          = var.target_region
        Env             = var.target_env
        App             = var.target_app
        Service         = var.target_service
    }
}

