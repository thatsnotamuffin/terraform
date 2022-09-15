terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "ec2/general-instance/no-data-vol/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "general_instance_no_data_vol" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//ec2/general_instance/no_data_vol?ref=<relevant tag>"

    target_subnet           = "subnet-000aaa111bbb"
    target_security_groups  = ["sg-000aaa111bbb", "sg-222ccc333ddd"]
    target_region           = "us-east-1"
    target_env              = "Stage"
    target_app              = "MyApp"
    target_service          = "MyService"
    
    instance_settings = {
        global_ami          = "ami-000aaa111bbb"
        instance_type       = "m5.large"
        instance_name       = "MyInstance"
        ssh_key             = "my-ssh-key"
    }

    root_vol_settings = {
        vol_type            = "gp3"
        root_vol_size       = 50
        encrypted_volume    = true
        kms_key             = "arn:aws:kms:us-east-1:000aaa111bbbc:key/0123abcd"
    }
}

