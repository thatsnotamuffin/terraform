##-- EBS Volume Variables --##

variable "target_zone" {
    type = string
    description = "Availability Zone to create the volume - I.E. us-west-2a"
}

variable "target_snapshot" {
    type = string
    description = "Snapshot ID that the volume is based on"
}

variable "vol_name" {
    type = string
    description = "The name of the volume - I.E. data-vol-nginx-2"
}

variable "target_region" {
    type = string
    description = "Used for tagging - Region that the volume is created in - I.E. us-east-1"
}

variable "target_env" {
    type = string
    description = "Used for tagging - Environment the volume is being created for"
}

variable "target_app" {
    type = string
    description = "The app the volume is supporting - if not applicable just use N/A"
}

variable "target_service" {
    type = string
    description = "The service the volume is supporting - if not applicable just use N/A"
}

variable "kms_key" {
    type = string
    description = "The ARN of the KMS key used to encrypt the volume - this is required"
}

