variable "target_domain" {
    description = "Name of the OpenSearch domain to create"
}

variable "engine_version" {
    description = "Engine version - default is OpenSearch 1.2 - version is expressed as OpenSearch_1.2"
    default = "OpenSearch_1.2"
}

variable "instance_type" {
    description = "Instance type to host the OpenSearch domain"
}

variable "target_region" {
    description = "Region the OpenSearch domain is created in"
}

variable "target_env" {
    description = "Environment deployed to"
}

variable "target_app" {
    description = "App being supported by OpenSearch"
}

