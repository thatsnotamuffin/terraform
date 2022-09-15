## Attachs a created EBS volume to an EC2 instance ##

resource "aws_volume_attachment" "attach_ebs_volume" {
    device_name                         = var.device_name
    volume_id                           = var.target_volume
    instance_id                         = var.target_instance

    force_detach                        = var.volume_force_detach
    skip_destroy                        = var.skip_destroy
    stop_instance_before_detaching      = var.stop_instance_detach
}

