variable "device_name" {
    type = string
    description = "The device name to expose to the instance - I.E. /dev/sdh"
    default = "/dev/xvdb"  
}

variable "target_volume" {
    type = string
    description = "The Volume ID of the EBS volume to attach to the instance"
}

variable "target_instance" {
    type = string
    description = "Instance ID to attach the EBS volume to"
}

variable "volume_force_detach" {
    type = bool
    description = "Forces the volume to detach if set to true - can result in data loss"
    default = false
}

variable "skip_destroy" {
    type = bool
    description = "If set to true - Removes the volume attachment from the terraform state but does not detach when the instance is destroyed"
    default = true
}

variable "stop_instance_detach" {
    type = bool
    description = "If set to true - stops the target instance before detaching the volume"
    default = true
}
