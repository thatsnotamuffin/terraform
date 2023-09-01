module "dev_ami" {
    source = "../modules/create-ami"

    # AMI Settings
    ami_name = "prod-general-ami"
    source_instance_id = "i-111aaa222bbb333ccc"
}
