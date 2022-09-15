#-- General EC2 Instance Variables --#
variable "instance_settings" {
    type = map(any)
    description = "General instance settings"
}

variable "target_region" {
    type = string
    description = "Region where the instance will be deployed"
}

variable "target_env" {
    type = string
    description = "Environment where the instance will be deployed"
}

variable "target_service" {
    type = string
    description = "Service the instance is supporting"
}

variable "target_app" {
    type = string
    description = "App that the instance is supporting"
}

variable "target_security_groups" {
    type = list(string)
    description = "A list of security groups applied to the EC2 instance"
}

variable "target_subnet" {
    type = string
    description = "The subnet id hosting the EC2 instance"
}

variable "root_vol_settings" {
    type = map(any)
    description = "A map of settings for the root volume"
}

