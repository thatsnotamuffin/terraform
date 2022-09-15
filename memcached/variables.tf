##- Memcached Variables -##

variable "db_subnets" {
    type = list(string)
    description = "A list of DB subnets to host the Memcached service"
}

variable "memcached" {
    type = map(any)
    description = "A map of the Memcached settings - subnet_group_name (str) , cluster_id (str) , node_type (str) , num_cache_nodes (int) , parameter_group_name (str) , target_region (str) , target_env (str) , port (int)"
}

variable "target_security_groups" {
    type = list(string)
    description = "A list of security groups to be applied to the Memcached service"
}
