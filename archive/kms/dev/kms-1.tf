module "ebs_kms" {
    source = "../modules/kms-key"

    # Tags
    purpose = "Encrypts EBS volumes"
    region = "us-east-1"
    environment = "Development"

    # Key
    kms_key_alias = "alias/ebs-volumes-dev"
    description = "Encrypts EBS volumes in dev environment"
    deletion_window_in_days = 10
    enable_key_rotation = true
}
