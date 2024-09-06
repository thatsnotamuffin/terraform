# Databases
A collection of database modules for DynamoDB, Memcached, and RDS (Postgres default)

## DynamoDB
A module to deploy a DynamoDB table

[DynamoDB Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/dynamodb_table)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `table_name` | String | Name of the DynamoDB Table | my_table |
| `billing_mode` | String | Billing mode for the table | PROVISIONED |
| `read_capacity` | Number | Number of read units | 15 |
| `write_capacity` | Number | Number of write units | 15 |
| `hash_key` | String | Attribute as the hash (partition key) | Path |
| `range_key` | String | Attribute as the range (sort) key | Key |
| `point_in_time_recovery` | Bool | Enable point in time recovery | false |
| `table_hash_name` | String | Name of the attribute | Path |
| `table_hash_type` | String | Attribute type - valid values are S (string) - N (number) - B (binary) | S |
| `table_range_name` | String | Name of the attribute | Key |
| `table_range_type` | String | Attribute type - valid values are S (string) - N (number) - B (binary) | S |
| `table_encryption_enabled` | Bool | Enable encryption | true |
| `table_kms_key` | String | ARN of the KMS key | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `region` | String | Region the DynamoDB table is deployed in | us-east-1 |
| `environment`| String | Environment the table is deployed for | dev |
| `supported_service` | String | Service the DynamoDB table supports | Metadata |
| `supported_app` | String | Application the table supports | My App |

## Memcached
A module that creates an Elasticache subnet group and Elasticache cluster running the Memcached engine

[Elasticache Subnet Group Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/elasticache_subnet_group)

[Elasticache Cluster Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/elasticache_cluster)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `subnet_group_name` | String | Name of the subnet group | my_subnet_group |
| `subnet_group_ids` | List(String) | List of Subnet IDs to use for the subnet group | ["subnet-111aaa", "subnet-222bbb"] |
| `cluster_id` | String | Name of the Memcached cluster | my_cluster |
| `node_type` | String | Instance class to be used for the cluster - Refer to [AWS docs](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/CacheNodes.SupportedTypes.html) for valid instance types | cache.t3.medium |
| `num_cache_nodes` | Number | Number of nodes for the Memcached cluster | 2 |
| `parameter_group_name` | String | Parameter group name to apply to the cluster | default.memcached1.6 |
| `port` | Number | Port to use for the cache nodes | 11211 |
| `security_group_ids` | List(String) | List of security group IDs to use for the cluster | ["sg-111aaa", "sg-222bbb"] |
| `apply_immediately` | Bool | Apply changes immediately or during a maintenance window | false |
| `maintenance_window` | String | The weekly time range for when maintenance is performed - ddd:hh24:mi-ddd:hh24:mi | sun:05:00-sun:09:00 |
| `region` | String | Region the DynamoDB table is deployed in | us-east-1 |
| `environment`| String | Environment the table is deployed for | dev |
| `supported_service` | String | Service the DynamoDB table supports | Metadata |
| `supported_app` | String | Application the table supports | My App |

## RDS
### db-subnet
A module that creates an RDS subnet group

[RDS Subnet Group Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/db_subnet_group)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `subnet_group_name` | String | Name of the subnet group | my_subnet_group |
| `subnet_ids` | List(String) | List of subnet IDs to use for the subnet group | ["subnet-111aaa", "subnet-222bbb"] |
| `region` | String | Region the DynamoDB table is deployed in | us-east-1 |
| `environment`| String | Environment the table is deployed for | dev |

### db - fresh-db
A module that creates a new RDS instance. This module uses two sensitive values `username` and `password`. It's suggested to enter these on the command line or a secure environment

Example command: `terraform apply -var "username=pgadmin" -var "password=mypassword"`

[RDS DB Instance Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/db_instance)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `db_identifier` | String | Name of the database | my-rds-database |
| `engine` | String | Name of the database engine to be used | postgres |
| `engine_version` | String | Engine version to use | 13 |
| `instance_class` | String | Instance class for the database - refer to AWS documentation | db.m6g.large |
| `deletion_protection` | Bool | Enable deletion protection | true |
| `parameter_group_name` | String | Name of the parameter group for the database | default.postgres13 |
| `allocated_storage` | Number | Storage in GB | 100 |
| `storage_encrypted` | Bool | Encrypt storage | true |
| `kms_key_id` | String | ARN of the KMS key used to encrypt | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `storage_type` | String | Storage type - refer to [AWS documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html) | gp3 |
| `db_name` | String | Name of the database to create when the instance is created | postgres |
| `username` | String | Username for the master user - Sensitive value | pgadmin |
| `password` | String | Password for the master user - Sensitive value | mypassword |
| `db_subnet_group_name` | String | DB subnet group name | my_subnet_group |
| `iam_database_authentication_enabled` | Bool | Enable IAM database authentication | false |
| `vpc_security_group_ids` | List(String) | List of security group IDs | ["sg-111aaa", "sg-222bbb"] |
| `allow_major_version_upgrade` | Bool | Allow major version upgrade | false |
| `auto_minor_version_upgrade` | Bool | Allow auto minor version upgrade | true |
| `maintenance_window` | String | The weekly time range for when maintenance is performed - ddd:hh24:mi-ddd:hh24:mi | sun:05:00-sun:09:00 |
| `apply_immediately` | Bool | Apply changes immediately | false |
| `skip_final_snapshot` | Bool | Skip final snapshot when database is deleted | false |
| `final_snapshot_identifier` | String | Final snapshot name | my_rds_database_final |
| `backup_retention_period` | Number | Backup retention in days | 30 |
| `backup_window` | String | Backup window - daily time range 24h in UTC - cannot overlap with maintenance window | 22:00-00:00 |
| `copy_tags_to_snapshot` | Bool | Copy the RDS DB instance tags to the snapshots | true |
| `region` | String | Region the DynamoDB table is deployed in | us-east-1 |
| `environment`| String | Environment the table is deployed for | dev |
| `supported_service` | String | Service the DynamoDB table supports | Metadata |
| `supported_app` | String | Application the table supports | My App |

### db - from-snapshot
A module that creates a new RDS instance from a snapshot

[RDS DB Instance Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/db_instance)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `snapshot_identifier` | String | Snapshot ID to create the database from | rds:my-rds-database |
| `db_identifier` | String | Name of the database | my-rds-database |
| `instance_class` | String | Instance class for the database - refer to AWS documentation | db.m6g.large |
| `deletion_protection` | Bool | Enable deletion protection | true |
| `parameter_group_name` | String | Name of the parameter group for the database | default.postgres13 |
| `storage_encrypted` | Bool | Encrypt storage | true |
| `kms_key_id` | String | ARN of the KMS key used to encrypt | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `storage_type` | String | Storage type - refer to [AWS documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html) | gp3 |
| `db_subnet_group_name` | String | DB subnet group name | my_subnet_group |
| `iam_database_authentication_enabled` | Bool | Enable IAM database authentication | false |
| `vpc_security_group_ids` | List(String) | List of security group IDs | ["sg-111aaa", "sg-222bbb"] |
| `allow_major_version_upgrade` | Bool | Allow major version upgrade | false |
| `auto_minor_version_upgrade` | Bool | Allow auto minor version upgrade | true |
| `maintenance_window` | String | The weekly time range for when maintenance is performed - ddd:hh24:mi-ddd:hh24:mi | sun:05:00-sun:09:00 |
| `apply_immediately` | Bool | Apply changes immediately | false |
| `skip_final_snapshot` | Bool | Skip final snapshot when database is deleted | false |
| `final_snapshot_identifier` | String | Final snapshot name | my_rds_database_final |
| `backup_retention_period` | Number | Backup retention in days | 30 |
| `backup_window` | String | Backup window - daily time range 24h in UTC - cannot overlap with maintenance window | 22:00-00:00 |
| `copy_tags_to_snapshot` | Bool | Copy the RDS DB instance tags to the snapshots | true |
| `region` | String | Region the DynamoDB table is deployed in | us-east-1 |
| `environment`| String | Environment the table is deployed for | dev |
| `supported_service` | String | Service the DynamoDB table supports | Metadata |
| `supported_app` | String | Application the table supports | My App |

### parameter-group

Coming Soon-ish

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |

### snapshot
A module that creates a snapshot of an RDS instance

[RDS Snapshot Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/db_snapshot)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `db_instance` | String | The database identifier to take the snapshot from | my-rds-instance |
| `db_snapshot_identifier` | String | The name of the snapshot | my_rds_snapshot |
| `region` | String | Region the DynamoDB table is deployed in | us-east-1 |
| `environment`| String | Environment the table is deployed for | dev |