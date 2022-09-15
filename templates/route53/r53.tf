terraform {
  backend "s3" {
      bucket                = "terraform-state-bucket"
      key                   = "route53/terraform.tfstate"
      region                = "us-east-1"
      encrypt               = true
      kms_key_id            = "alias/terraform-bucket-key"
      dynamodb_table        = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "r53_records" {
    source = "git::https://github.com/thatsnotamuffin/terraform.git//route53?ref=<relevant tag>"

    target_region           = "us-east-1"

    route_53_records = {
        mail_google = {
            zone_id         = "ROUTE53ZoneID"
            r53_name        = "mail.example.com"
            record_type     = "CNAME"
            r53_ttl         = 300
            record_list     = ["mail.example.com."]
        },
        mail_sendgrid = {
            zone_id         = "ROUTE53ZoneID"
            r53_name        = "mailer.example.com"
            record_type     = "CNAME"
            r53_ttl         = 300
            record_list     = ["example.net."]
        }
    }
}

