##-- General EC2 Instance Configuration --##

# This module creates a general EC2 instances

# EC2 instance with no data volume
resource "aws_instance" "ec2_server" {
    
    ami                     = var.instance_settings.global_ami
    instance_type           = var.instance_settings.instance_type

    root_block_device {
      volume_type           = var.root_vol_settings.vol_type
      volume_size           = var.root_vol_settings.root_vol_size
      encrypted             = var.root_vol_settings.encrypted_volume
      kms_key_id            = var.root_vol_settings.kms_key

      tags = {
          Name              = "root-vol-${var.instance_settings.instance_name}"
          Region            = var.target_region
          Env               = var.target_env
          Service           = var.target_service
          App               = var.target_app
      }
    }

    vpc_security_group_ids  = var.target_security_groups

    subnet_id               = var.target_subnet

    key_name                = var.instance_settings.ssh_key

    tags = {
        Name                = var.instance_settings.instance_name
        Region              = var.target_region
        Env                 = var.target_env
        Service             = var.target_service
        App                 = var.target_app
    }
}

