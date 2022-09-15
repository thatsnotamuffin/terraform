##-- MongoDB EC2 Variables --##

#- General
variable "cluster_count" {
    type = number
    description = "The number of MongoDB servers to be created in the target ReplicaSet"
    default = 3
}

#- Security
variable "target_security_groups" {
    type = list(string)
    description = "A list of security groups to be applied to the MongoDB resources"
}

#- Network
variable "db_subnets" {
    type = list(string)
    description = "The private subnets that these resources will be created in"
}

variable "target_env" {
    type = string
    description = "The target environment - I.E. prod-us"
}

variable "target_region" {
    type = string
    description = "The target region - I.E. us-east-1"
}

#- EC2 Instance Settings
variable "general_instance_settings" {
    type = map(any)
    description = "A map of the general instance settings - Consists of global_ami (str) , encrypted_volume (bool) , vol_type (str) , root_vol_size (int) , ssh_key (str) , kms_key (arn as str)"
}

variable "mongodb_settings" {
    type = map(any)
    description = "A map of the MongoDB instance settings - consists of mongo_instance_type (str) , mongodb_data_volume (int) , mongodb_replset (str) , mongodb_description (str) , target_app (str)"
}

variable "arbiter_settings" {
    type = map(any)
    description = "A map of the MongoDB arbiter settings"
}

variable "data_vol_ids" {
    type = list(string)
    description = "A list of volume IDs to attach to the instance" 
}

variable "arbiter_data_vol" {
    type = string
    description = "The volume ID of the arbiter's data volume to attach to the instance"
}

variable "data_vol_destroy" {
    type = bool
    description = "Set this to true if you want to detach the volume from the instance at destroy time"
    default = false
}

variable "mongo_instance_names" {
    type = list(string)
    description = "The list of instance names - not DNS names for the target MongoDB instances"
}

#- Route53
variable "mongo_hostnames" {
    type = list(string)
    description = "A list of host names including the base url - I.E. mongo-1.example.com"
}

variable "mongodb_record" {
    type = map(any)
    description = "A map containing information for the target zone and related information to create DNS records - consists of zone_id (str) , ttl (int) , record_type (str)"
}

