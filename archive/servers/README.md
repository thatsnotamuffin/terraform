# Servers
A collection of modules for server configs.

## Elasticsearch
Creates an Elasticsearch cluster and associated resources. The number of EC2 instances are created for the cluster defined by the `cluster_count` variable. It's assumed this cluster is private and the ALB is set to `internal`. Route53 entries are created for each instance as well as an overall cluster DNS name for the ALB.

[EC2 Instance Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/instance)

[Volume Attachment](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/volume_attachment)

[Loadbalancer Target Group Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_target_group)

[Loadbalancer Target Group Attachment](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_target_group_attachment)

[Loadbalancer Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb)

[Loadbalancer Listener Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_listener)

[Route53 Record](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/route53_record)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `cluster_count` | Number | Number of instances in the Elasticsearch cluster | 2 |
| `ami` | String | AMI to use as the base image | ami-111aaa |
| `instance_type` | String | Instance type for the cluster - Refer to [AWS Documentation](https://aws.amazon.com/ec2/instance-types/) for available instance types | t3.medium |
| `volume_size` | Number | Size of the root volume in GB | 50 |
| `kms_key_id` | String | ARN of the KMS key used to encrypt the root device | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `vpc_security_group_ids` | List(String) | List of security group IDs to apply to the cluster | ["sg-111aaa", "sg-222bbb"] |
| `subnets` | List(String) | List of subnet IDs | ["subnet-111aaa", "subnet-222bbb] |
| `ssh_key` | String | Name of the SSH key | dev-admin |
| `instance_names` | List(String) | List of instance names | ["my-es-1", "my-es-2"] |
| `cluster_name` | String | Name of the Elasticsearch cluster | my-es-cluster |
| `cluster_description` | String | Description of the Elasticsearch cluster | My Elasticsearch Cluster |
| `data_vol_ids` | List(String) | List of volume IDs for the data volumes | ["vol-111aaa", "vol-222bbb"] |
| `data_vol_destroy` | Bool | Set this to true if you want to detach the volume from the instance at destroy time | false |
| `tg_name` | String | Name of the target group | my-es-tg |
| `vpc_id` | String | VPC ID | vpc-111aaa |
| `lb_name` | String | Name of the ALB | my-es-alb |
| `enable_deletion_protection` | Bool | Enable deletion protection on the ALB | true |
| `access_logs_enabled` | Bool | Enable access logs | true |
| `access_logs_bucket` | String | S3 bucket to send access logs to | my-es-bucket |
| `ssl_policy` | String | SSL policy to apply to the ALB listener | ELBSecurityPolicy-TLS13-1-2-2021-06 |
| `certificate_arn` | String | ARN of the SSL certificate in ACM | arn:aws:kms:us-east-1:111222333444:certificate/111aaa-22bb-33cc-44dd-555eee666fff |
| `es_listener_name` | String | Name of the ALB listener | my-es-listener |
| `zone_id` | String | Route53 Zone ID | Z111bbb222ccc333ddd |
| `cluster_dns_name` | String | Cluster DNS name | my-es-cluster.myurl.com |
| `hostnames` | List(String) | List of hostnames for the cluster | ["my-es-cluster-1.myurl.com", "my-es-cluster-2.myurl.com] |
| `region` | String | Region the resources are created in | us-east-1 |
| `environment` | String | Environment the resources are created for | dev |
| `supported_service` | String | Service the resources support | Elasticsearch |
| `supported_app` | String | App the resources support | My App |

## MongoDB
Creates a MongoDB replicaset with an arbiter instance. The number of EC2 instances that are created for the replicaset is defined by the `replset_count` variable. Route53 entries are created for each instance.

The MongoDB data instances and the arbiter instance are largely segregated. To avoid unnecessary complexity in trying to determine or force a specific instance in a list of instances to be the arbiter, it was decided to use separate resource blocks and variables to accomodate and prevent unnecessary complexity within the terraform config.

[EC2 Instance Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/instance)

[Volume Attachment](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/volume_attachment)

[Route53 Record](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/route53_record)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `replset_count` | Number | Number of data instances in the replication set | 2 |
| `ami` | String | AMI to use as the base image | ami-111aaa |
| `instance_type` | String | Instance type for the replicaset - Refer to [AWS Documentation](https://aws.amazon.com/ec2/instance-types/) for available instance types | t3.medium |
| `volume_size` | Number | Size of the root EBS volume in GB | 50 |
| `volume_type` | String | Volume type for the root volume | gp3 |
| `kms_key_id` | String | ARN of the KMS key to encrypt the root volume | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `replset_instance_names` | List(String) | List of the replication set instance names | ["my-mongo-1", "my-mongo-2"] |
| `vpc_security_group_ids` | List(String) | List of security group IDs | ["sg-111aaa", "sg-222bbb"] |
| `db_subnets` | List(String) | Llist of subnet IDs | ["subnet-111aaa", "subnet-222bbb"] |
| `ssh_key` | String | Name of the SSH key | dev-admin |
| `mongo_replset` | String | Name of the MongoDB replication set | my-mongo-replicaset |
| `mongo_description` | String | Description of the MongoDB replication set | my-mongo-replicaset |
| `mongo_hostnames` | List(String) | A list of hostnames for the mongo data instances | ["my-mongo-1.myurl.com", "my-mongo-2.myurl.com"] |
| `arbiter_instance_name` | String | Name of the arbiter instance | my-mongo-3 |
| `arbiter_subnet` | String | Subnet ID for the arbiter instance | "subnet-333ccc" |
| `arbiter_hostname` | String | Hostname of the arbiter instance | my-mongo-3.myurl.com |
| `data_vol_ids` | List(String) | A list of EBS volume IDs for the mongo data volumes | ["vol-111aaa", "vol-222bbb"] |
| `data_vol_destroy` | Bool | Set this to true if you want to detach the volume from the instance at destroy time | false |
| `arbiter_data_vol` | String | Volume ID for the arbiter volume | vol-333ccc |
| `zone_id` | String | Zone ID for the Route53 zone | Z111bbb222ccc333ddd |
| `region` | String | Region the resources are created in | us-east-1 |
| `environment` | String | Environment the resources are created for | dev |
| `supported_service` | String | Service the resources support | Elasticsearch |
| `supported_app` | String | App the resources support | My App |

## NGINX
Creates a set of NGINX instances and an associated load balancer with HTTP and HTTPS listeners. A security group allowing HTTPS and HTTP ingress is created. As well as Route53 entries for the individual NGINX instances and the ALB.

[Security Group Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/security_group)

[EC2 Instance Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/instance)

[Volume Attachment](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/volume_attachment)

[Networking Interface Security Group Attachment Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/network_interface_sg_attachment)

[Loadbalancer Target Group Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_target_group)

[Loadbalancer Target Group Attachment](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_target_group_attachment)

[Loadbalancer Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb)

[Loadbalancer Listener Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/lb_listener)

[Route53 Record](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/route53_record)

### Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `nginx_web_security_group_name` | String | Name of the NGINX web group to allow HTTP and HTTPS traffic | allow-web |
| `web_vpc` | String | The VPC to create the web resources | vpc-111aaa |
| `nginx_count` | Number | The number of NGINX instances to create | 2 |
| `nginx_ami` | String | AMI to use as the base image | ami-111aaa |
| `nginx_instance_type` | String | Instance type for the NGINX servers - Refer to [AWS Documentation](https://aws.amazon.com/ec2/instance-types/) for available instance types | t3.medium |
| `nginx_root_vol_size` | Number | The size of the root volume in GB | 50 |
| `ebs_kms_key` | String | ARN of the EBS KMS key | arn:aws:kms:us-east-1:111222333444:key/111aaa-22bb-33cc-44dd-555eee666fff |
| `domain_environment` | String | Domain environment this resource will be created in | dev |
| `web_security_groups` | List(String) | List of security group IDs | ["sg-111aaa", "sg-222bbb"] |
| `web_subnets` | List(String) | List of subnet IDs | ["subnet-111aa", "subnet-222bbb"] |
| `ssh_key` | String | Name of the SSH key | dev-admin |
| `nginx_instance_names` | List(String) | List of NGINX instance names | ["my-nginx-1", "my-nginx-2"] |
| `nginx_tg_name` | String | Name of the target group | my-nginx-tg |
| `nginx_lb_name` | String | Name of the NGINX ALB | my-nginx-alb |
| `nginx_enable_deletion_protection` | Bool | Enable deletion protection on the ALB | false |
| `nginx_lb_access_logs_enabled` | Bool | Enable access logs | true |
| `alb_logs_bucket` | String | Name of the S3 bucket to send access logs | my-nginx-bucket |
| `nginx_ssl_policy` | String | SSL policy for the loadbalancer | ELBSecurityPolicy-TLS13-1-2-2021-06 |
| `nginx_cert_arn` | String | ARN of the SSL certificate in ACM | arn:aws:kms:us-east-1:111222333444:certificate/111aaa-22bb-33cc-44dd-555eee666fff |
| `nginx_https_listener_name` | String | Name of the NGINX HTTPS listener | my-nginx-https |
| `nginx_http_listener_name` | String | Name of the NGINX HTTP listener | my-nginx-http |
| `nginx_zone_id` | String | Zone ID for NGINX | Z111bbb222ccc333ddd |
| `nginx_route53_name` | String | Name of the Route53 record for the NGINX ALB | my-nginx.myurl.com |
| `nginx_hostnames` | List(String) | List of hostnames for the NGINX servers | ["my-nginx-1.myurl.com", "my-nginx-2.myurl.com"] |
| `region` | String | Region the resources are created in | us-east-1 |
| `environment` | String | Environment the resources are created for | dev |