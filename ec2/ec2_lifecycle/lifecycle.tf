##-- This module creates lifecycle policies for the NGINX - Elasticsearch - MongoDB servers --##

# NGINX
resource "aws_dlm_lifecycle_policy" "nginx_lifecycle" {
    description                 = "NGINX EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.nginx_lifecycle_settings.name

            create_rule {
                interval        = var.nginx_lifecycle_settings.interval
                interval_unit   = var.nginx_lifecycle_settings.interval_unit
                times           = var.nginx_times
            }

            retain_rule {
                count           = var.nginx_lifecycle_settings.retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Service             = "NGINX"            
        }
    }

    tags = {
        Name                    = "nginx-lifecycle"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "N/A"
        Service                 = "NGINX"
    }
}

##- Elasticsearch
#- Root Volumes
# Arugula
resource "aws_dlm_lifecycle_policy" "arugula_root_lifecycle" {
    count                       = var.cluster_count

    description                 = "Arugula Elasticsearch Root Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.arugula_lifecycle_settings.root_vol_name

            create_rule {
                interval        = var.arugula_lifecycle_settings.root_vol_interval
                interval_unit   = var.arugula_lifecycle_settings.root_vol_interval_unit
                times           = var.arugula_times_root
            }

            retain_rule {
                count           = var.arugula_lifecycle_settings.root_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "root-vol-${var.arugula_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "root-vol-${var.arugula_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Arugula"
        Service                 = "Elasticsearch"
    }
}

# Kale
resource "aws_dlm_lifecycle_policy" "kale_root_lifecycle" {
    count                       = var.cluster_count

    description                 = "Kale Elasticsearch Root Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.kale_lifecycle_settings.root_vol_name

            create_rule {
                interval        = var.kale_lifecycle_settings.root_vol_interval
                interval_unit   = var.kale_lifecycle_settings.root_vol_interval_unit
                times           = var.kale_times_root
            }

            retain_rule {
                count           = var.kale_lifecycle_settings.root_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "root-vol-${var.kale_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "root-vol-${var.kale_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Kale"
        Service                 = "Elasticsearch"
    }
}

# Turnip
resource "aws_dlm_lifecycle_policy" "turnip_root_lifecycle" {
    count                       = var.cluster_count

    description                 = "Turnip Elasticsearch Root Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.turnip_lifecycle_settings.root_vol_name

            create_rule {
                interval        = var.turnip_lifecycle_settings.root_vol_interval
                interval_unit   = var.turnip_lifecycle_settings.root_vol_interval_unit
                times           = var.turnip_times_root
            }

            retain_rule {
                count           = var.turnip_lifecycle_settings.root_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "root-vol-${var.turnip_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "root-vol-${var.turnip_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Turnip"
        Service                 = "Elasticsearch"
    }
}

#- Data Volumes
# Arugula
resource "aws_dlm_lifecycle_policy" "arugula_data_lifecycle" {
    count                       = var.cluster_count

    description                 = "Arugula Elasticsearch Data Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.arugula_lifecycle_settings.data_vol_name

            create_rule {
                interval        = var.arugula_lifecycle_settings.data_vol_interval
                interval_unit   = var.arugula_lifecycle_settings.data_vol_interval_unit
                times           = var.arugula_times_data
            }

            retain_rule {
                count           = var.arugula_lifecycle_settings.data_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "data-vol-${var.arugula_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "data-vol-${var.arugula_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Arugula"
        Service                 = "Elasticsearch"
    }
}

# Kale
resource "aws_dlm_lifecycle_policy" "kale_data_lifecycle" {
    count                       = var.cluster_count

    description                 = "Kale Elasticsearch Data Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.kale_lifecycle_settings.data_vol_name

            create_rule {
                interval        = var.kale_lifecycle_settings.data_vol_interval
                interval_unit   = var.kale_lifecycle_settings.data_vol_interval_unit
                times           = var.kale_times_data
            }

            retain_rule {
                count           = var.kale_lifecycle_settings.data_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "data-vol-${var.kale_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "data-vol-${var.kale_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Kale"
        Service                 = "Elasticsearch"
    }
}

# Turnip
resource "aws_dlm_lifecycle_policy" "turnip_data_lifecycle" {
    count                       = var.cluster_count

    description                 = "Turnip Elasticsearch Data Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.turnip_lifecycle_settings.data_vol_name

            create_rule {
                interval        = var.turnip_lifecycle_settings.data_vol_interval
                interval_unit   = var.turnip_lifecycle_settings.data_vol_interval_unit
                times           = var.turnip_times_data
            }

            retain_rule {
                count           = var.turnip_lifecycle_settings.data_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "data-vol-${var.turnip_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "data-vol-${var.turnip_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Turnip"
        Service                 = "Elasticsearch"
    }
}

##- MongoDB
#- Root Volumes
# Napa
resource "aws_dlm_lifecycle_policy" "napa_root_lifecycle" {
    count                       = var.cluster_count

    description                 = "Napa MongoDB Root Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.napa_lifecycle_settings.root_vol_name

            create_rule {
                interval        = var.napa_lifecycle_settings.root_vol_interval
                interval_unit   = var.napa_lifecycle_settings.root_vol_interval_unit
                times           = var.napa_times_root
            }

            retain_rule {
                count           = var.napa_lifecycle_settings.root_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "root-vol-${var.napa_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "root-vol-${var.napa_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Napa"
        Service                 = "MongoDB"
    }
}

# Savoy
resource "aws_dlm_lifecycle_policy" "savoy_root_lifecycle" {
    count                       = var.cluster_count

    description                 = "Savoy MongoDB Root Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.savoy_lifecycle_settings.root_vol_name

            create_rule {
                interval        = var.savoy_lifecycle_settings.root_vol_interval
                interval_unit   = var.savoy_lifecycle_settings.root_vol_interval_unit
                times           = var.savoy_times_root
            }

            retain_rule {
                count           = var.savoy_lifecycle_settings.root_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "root-vol-${var.savoy_instance_names[count.index]}"
        }
    }
    
    tags = {
        Name                    = "root-vol-${var.savoy_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Savoy"
        Service                 = "MongoDB"
    }
}

#- Data Volumes
# Napa
resource "aws_dlm_lifecycle_policy" "napa_data_lifecycle" {
    count                       = var.cluster_count

    description                 = "Napa MongoDB Root Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.napa_lifecycle_settings.data_vol_name

            create_rule {
                interval        = var.napa_lifecycle_settings.data_vol_interval
                interval_unit   = var.napa_lifecycle_settings.data_vol_interval_unit
                times           = var.napa_times_data
            }

            retain_rule {
                count           = var.napa_lifecycle_settings.data_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "data-vol-${var.napa_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "data-vol-${var.napa_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Napa"
        Service                 = "MongoDB"
    }
}

# Savoy
resource "aws_dlm_lifecycle_policy" "savoy_data_lifecycle" {
    count                       = var.cluster_count

    description                 = "Savoy MongoDB Root Volume EC2 Lifecycle Policy"
    execution_role_arn          = var.lifecycle_general_settings.role
    state                       = var.lifecycle_general_settings.state

    policy_details {
        resource_types          = ["VOLUME"] # Currently this is the only allowed value

        schedule {
            name                = var.savoy_lifecycle_settings.data_vol_name

            create_rule {
                interval        = var.savoy_lifecycle_settings.data_vol_interval
                interval_unit   = var.savoy_lifecycle_settings.data_vol_interval_unit
                times           = var.savoy_times_data
            }

            retain_rule {
                count           = var.savoy_lifecycle_settings.data_vol_retain_count
            }

            copy_tags           = true
        }

        target_tags = {
            Name                = "data-vol-${var.savoy_instance_names[count.index]}"
        }
    }

    tags = {
        Name                    = "data-vol-${var.savoy_instance_names[count.index]}"
        Env                     = var.lifecycle_general_settings.target_env
        Region                  = var.lifecycle_general_settings.target_region
        App                     = "Savoy"
        Service                 = "MongoDB"
    }
}