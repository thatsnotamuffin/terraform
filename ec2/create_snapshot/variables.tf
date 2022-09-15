##-- Snapshot Variables --##

variable "target_vol" {
    type        = string
    description = "The Volume ID to take a snapshot of: vol-112233aabb"
}

variable "vol_description" {
    type        = string
    description = "A description of the volume and/or snapshot"
}

variable "snap_name" {
    type        = string
    description = "Name of the snapshot to be created"
}

variable "target_region" {
    type        = string
    description = "Region this snapshot is being created in - needs to be specific I.E. us-east-1a"
}

variable "target_env" {
    type        = string
    description = "Environment the snapshot is being created for - kastage - pilyr - prod-us"
}

variable "target_app" {
    type        = string
    description = "Application that the snapshot supports - Napa - Savoy - Arugula"
}

variable "target_service" {
    type        = string
    description = "Service that the snapshot supports - Mongo - Elasticsearch - NGINX"

