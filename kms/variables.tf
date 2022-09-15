##-- KMS Key Variables --##

# This contains the various variables used in the kms.tf file as well as some defaults

variable "kms_key_settings" {
    type = map(any)
    description                 = "Map of KMS Key settings - description (str) , deletion_window_days (int) , enable_rotation (bool) , alias (str)"
    default = {
        description             = "This key is used to encrypt stuff"
        deletion_window_days    = 10
        enable_rotation         = true
        alias                   = "alias/kms-key"
    }
}
