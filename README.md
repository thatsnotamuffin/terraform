# General Overview
A collection of Terraform modules built for the various environments. This repo provides a single point to update terraform code when new terraform versions are available.

## Templates
The templates directory has example files of how each module can be used. These example files are almost direct copies of how some infrastructure has been deployed.

## RDS Fresh DB
When running `terraform plan` or `terraform apply` with the fresh_db module, you'll need to pass the database username and password.

For example: `terraform plan -var 'rds_db_username=myuser' -var 'rds_db_password=mypassword'`
