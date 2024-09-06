# Storage

## EBS
A collection of modules for EBS configs. All volumes are assumed to be encrypted.

### Snapshots
This module creates a snapshot from an EBS volume

[EBS Snapshot Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ebs_snapshot)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `volume_id` | String | Source volume the snapshot is created from | vol-111aaa |
| `description` | String | A description for the snapshot | This is my snapshot |
| `snapshot_name` | String | Name of the snapshot | my_snapshot |
| `region` | String | Region the snapshot is created in | us-east-1 |
| `environment` | String | Environment the snapshot is created for | dev |
| `supported_app` | String | App the snapshot supports | My App |
| `supported_service` | String | Service the snapshot supports | NGINX |

### Volumes - empty_volume
This module creates a 'blank' volume without a filesystem or any associated data. 

[EBS Volume Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ebs_volume)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `az_id` | String | Availibility Zone ID for the volume | us-east-1c |
| `final_snapshot` | Bool | Create a snapshot of the volume when it's deleted | true |
| `vol_size` | Number | The size in GB of the volume | 100 |
| `kms_key_id` | String | ARN of the KMS key used to encrypt | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `iops` | Number | The iOPS for the volume | 3000 |
| `throughput` | Number | The throughput of the volume in MiB/s | 125 |
| `vol_name` | String | The name of the EBS volume | my-volume |
| `region` | String | Region the snapshot is created in | us-east-1 |
| `environment` | String | Environment the snapshot is created for | dev |
| `supported_app` | String | App the snapshot supports | My App |
| `supported_service` | String | Service the snapshot supports | NGINX |

### Outputs
| Output | Purpose |
| ---- | ---- |
| `empty_vol_id` | Volume ID |

### Volumes - from_snapshot
This module creates an EBS volume from a snapshot

[EBS Volume Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ebs_volume)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `az_id` | String | Availibility Zone ID for the volume | us-east-1c |
| `final_snapshot` | Bool | Create a snapshot of the volume when it's deleted | true |
| `snapshot_id` | String | ID of the snapshot to create the volume from | snap-111aaa222 |
| `vol_size` | Number | Size of the volume in GB | 100 |
| `kms_key_id` | String | ARN of the KMS key used to encrypt | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `iops` | Number | The iOPS for the volume | 3000 |
| `throughput` | Number | The throughput of the volume in MiB/s | 125 |
| `vol_name` | String | The name of the EBS volume | my-volume |
| `region` | String | Region the snapshot is created in | us-east-1 |
| `environment` | String | Environment the snapshot is created for | dev |
| `supported_app` | String | App the snapshot supports | My App |
| `supported_service` | String | Service the snapshot supports | NGINX |

### Outputs
| Output | Purpose |
| ---- | ---- |
| `empty_vol_id` | Volume ID |

## ECR
Modules for creating container repositories and lifecycle policies

### ecr-policy
Lifecycle policy for the container repository. Triggers on all tagged images with alphanumeric characters with a `countType` of `imageCountMoreThan` and untagged images with a `countType` of `sinceImagePushed`

[ECR Lifecycle Policy](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ecr_lifecycle_policy)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `container_repo` | String | Name of the container repository | my-app |
| `image_retention_count` | Number | The amount of images to retain | 100 |
| `untagged_image_retention` | Number | How many days to retain untagged images | 14 |

### ecr-repo
Creates a container repository

[ECR Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ecr_repository)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `name` | String | Name of the container repository | my-app |
| `image_tag_mutability` | String | Mutability setting for the repo | MUTABLE |
| `scan_on_push` | Bool | Scan the images when pushed to ECR | false |
| `region` | String | Region the repository is created in | us-east-1 |

## Lifecycle
Creates a lifecycle policy - written in mind for EBS volumes but not a hard requirement

[DLM Lifecycle Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/dlm_lifecycle_policy)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `description` | String | Description for the lifeycle | Lifecycle for EBS volumes |
| `execution_role_arn` | String | ARN of the execution role to create the snapshots | arn:aws:iam::111222333444555:role/lifecycle-role |
| `state` | String | Lifecycle is Enabled or Disabled | ENABLED |
| `resource_types` | List(String) | Resource types for the lifecycle - VOLUME - INSTANCE | VOLUME |
| `schedule_name` | String | Name of the schedule | my-ebs-lifecycle-schedule |
| `create_interval` | Number | How often in hours this policy is to be executed | 24 |
| `create_interval_unit` | String | Interval unit to execute the policy - only HOURS is currently supported | HOURS |
| `times` | List(String) | Times to execute the policy - 24h | ["23:00"] |
| `retain_interval` | Number | How long to retain the snapshot | 7 |
| `retain_interval_unit` | String | Unit to describe the retention interval - HOURS - DAYS - MONTHS - YEARS | DAYS |
| `copy_tags` | Bool | Copy the tags from the source | true |
| `target_name` | String | Naming convention of the snapshot | my-ebs-volume |
| `lifecycle_name` | String | Name of the lifecycle | my-lifecycle |
| `region` | String | Region the snapshot is created in | us-east-1 |
| `environment` | String | Environment the snapshot is created for | dev |

## S3
Modules for creating S3 buckets and access settings

### access-settings
This module contains the possible access settings for S3 buckets. The default values are all null, so each access setting can be applied individually without the need to reference additional modules

[S3 Bucket Server Side Encryption Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/s3_bucket_server_side_encryption_configuration)

[S3 Bucket ACL Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/s3_bucket_acl)

[S3 Bucket Public Access Block Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/s3_bucket_public_access_block)

[S3 Bucket Versioning Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/s3_bucket_versioning)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `bucket` | String | Name of the S3 bucket | my-bucket |
| `kms_key` | String | ARN of the KMS key to encrypt the bucket | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `algorithm` | String | Algorithm to encrypt the S3 bucket | aws:kms |
| `object_ownership` | String | Ownership of the bucket objects | BucketOwnerPreferred |
| `acl` | String | ACL to apply to the bucket | private |
| `block_public_acls` | Bool | Block public ACLs | true |
| `block_public_policy` | Bool | Block public policies | true |
| `ignore_public_acls` | Bool | Ignore public ACLs | true |
| `restrict_public_buckets` | Bool | Restrict public bucket policies | true |
| `status` | String | Enable versioning - Enabled - Disabled - Suspended | Enabled |

### create-bucket
Creates an S3 bucket

[S3 Bucket Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/s3_bucket)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `bucket` | String | Name of the S3 bucket | my-bucket |
| `force_destroy` | Bool | Delete the contents of the bucket when the bucket is destroyed | false |
| `purpose` | String | What data does the S3 bucket serve or store | Backup logs |
| `environment` | String | Environment the bucket is created for | dev |
