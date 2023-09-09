module "ebs_kms" {
    source = "../modules/kms-key"

    # Tags
    purpose = "Encrypts EBS volumes"
    region = "us-east-1"
    environment = "Production"

    # Key
    kms_key_alias = "alias/ebs-volumes-prod"
    description = "Encrypts EBS volumes in prod environment"
    deletion_window_in_days = 10
    enable_key_rotation = true
}
