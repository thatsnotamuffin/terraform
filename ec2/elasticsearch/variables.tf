##-- Elasticsearch EC2 Variables --##

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
variable "target_vpc" {
    type = string
    description = "The target VPC to create the target group and load balancer resources"
}

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

variable "elasticsearch_settings" {
    type = map(any)
    description = "A map of the elasticsearch instance settings - Consists of elasticsearch_instance_type (str) , target_app (str) , cluster_name (str) , cluster_description (str)"
}

variable "data_vol_ids" {
    type = list(string)
    description = "A list of volume IDs to attach to the instance" 
}

variable "data_vol_destroy" {
    type = bool
    description = "Set this to true if you want to detach the volume from the instance at destroy time"
    default = false
}

variable "elasticsearch_instance_names" {
    type = list(string)
    description = "A list of instance names - not DNS names for the target Elasticsearch instances"
}

variable "elasticsearch_hostnames" {
    type = list(string)
    description = "A list of the elasticsearch hostnames - I.E. arugula-1.example.com"
}

#- Target Group
variable "elasticsearch_tg_settings" {
    type = map(any)
    description = "A map of target group settings for elasticsearch - elastic_target_type (str) , elastic_tg_name (str) , port (int) , protocol (str)"
}

#- Load Balancer and Listener
variable "elastic_lb_settings" {
    type = map(any)
    description = "A map of the load balancer settings for elasticsearch - lb_name (str) , internal (bool) , loadbalancer_type (str) , deletion_protection (bool)"
}

variable "elastic_https_listener" {
    type = map(any)
    description = "A map of the HTTPS listener settings for elasticsearch - port (int) , protocol (str) , ssl (str) , cert_arn (str) , default_action_type (str) , listener_name (str)"
}

#- Route53 - DNS
variable "elastic_record" {
    type = map(any)
    description = "A map of the DNS record information for the elasticsearch instances - zone_id (str) , dns_name (str) , cluster_record_type (str) , ttl (int) , instance_record_type (str)"
}

