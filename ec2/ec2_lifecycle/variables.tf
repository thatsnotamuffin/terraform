##-- EC2 Lifecycle Variables --##

#- General
variable "cluster_count" {
    type = number
    description = "The number of servers in the target cluster - Each MongoDB and Elasticsearch cluster has had 3 servers up to this point"
    default = 3
}

variable "lifecycle_general_settings" {
    type = map(any)
    description = "General Settings for the EC2 Lifecycle Rules - role (str) , state (str)"
}

#- NGINX
variable "nginx_lifecycle_settings" {
    type = map(any)
    description = "NGINX EC2 Lifecycle Settings - name (str) , interval (int) , interval_unit (str) , retain_count (int)"
}

variable "nginx_times" {
    type = list(string)
    description = "The times that the backup will be taken"
}

##- Elasticsearch
# Arugula - Root and Data
variable "arugula_lifecycle_settings" {
    type = map(any)
    description = "Arugula Elasticsearch Lifecycle Settings - name (str) , interval (int), interval_unit (str) , retain_count (int)"
}

variable "arugula_times_root" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "arugula_times_data" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "arugula_instance_names" {
    type = list(string)
    description = "A list of instance names for the Arugula Elasticsearch cluster - not the Route53 records"
}

# Kale - Root and Data
variable "kale_lifecycle_settings" {
    type = map(any)
    description = "Kale Elasticsearch Lifecycle Settings - name (str) , interval (int), interval_unit (str) , retain_count (int)"
}

variable "kale_times_root" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "kale_times_data" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "kale_instance_names" {
    type = list(string)
    description = "A list of instance names for the Kale Elasticsearch cluster - not the Route53 records"
}

# Turnip - Root and Data
variable "turnip_lifecycle_settings" {
    type = map(any)
    description = "Turnip Elasticsearch Lifecycle Settings - name (str) , interval (int), interval_unit (str) , retain_count (int)"
}

variable "turnip_times_root" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "turnip_times_data" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "turnip_instance_names" {
    type = list(string)
    description = "A list of instance names for the Turnip Elasticsearch cluster - not the Route53 records"
}

#- MongoDB
# Napa - Root and Data
variable "napa_lifecycle_settings" {
    type = map(any)
    description = "Napa MongoDB Lifecycle Settings - name (str) , interval (int), interval_unit (str) , retain_count (int)"
}

variable "napa_times_root" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "napa_times_data" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "napa_instance_names" {
    type = list(string)
    description = "A list of instance names for the Napa MongoDB cluster - not the Route53 records"
}

# Savoy - Root and Data
variable "savoy_lifecycle_settings" {
    type = map(any)
    description = "Savoy MongoDB Lifecycle Settings - name (str) , interval (int), interval_unit (str) , retain_count (int)"
}

variable "savoy_times_root" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "savoy_times_data" {
    type = list(string)
    description = "The times that the backup will be taken"
}

variable "savoy_instance_names" {
    type = list(string)
    description = "A list of instance names for the Savoy MongoDB cluster - not the Route53 records"
}
