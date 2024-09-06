# AMI
This module provides configs to create an AMI from a current instance. Primarily to be used to create a backup or golden image of a desired instance state. 

A potential use case is creating an image of a running server to be used for small environment testing without the need to continuously run servers or retain seldom/intermittently needed EBS volumes and EC2 instances.

[AMI Documentation](https://registry.terraform.io/providers/hashicorp/aws/5.1.0/docs/resources/ami_from_instance)

## Required Input
| Variable | Variable Type | Description | Example |
| ---- | ---- | ---- | ---- |
| `ami_name` | String | Name of the AMI to be created | my_ami |
| `source_instance_id` | String | Instance ID of the source instance to create the AMI from | i-111aaa222bbb |
