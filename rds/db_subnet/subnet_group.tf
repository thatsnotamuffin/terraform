##-- RDS Subnet Group --##

resource "aws_db_subnet_group" "db_subnets" {
    name                                    = var.rds_subnet_group_settings.subnet_group_name
    subnet_ids                              = var.db_subnets

    tags = {
        Name                                = var.rds_subnet_group_settings.subnet_group_name
        Region                              = var.rds_subnet_group_settings.target_region
        Env                                 = var.rds_subnet_group_settings.target_env
        Service                             = var.rds_subnet_group_settings.target_service
    }
}
