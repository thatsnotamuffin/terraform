module "elasticsearch_volumes_data_1" {
  source = "../modules/volumes/empty_volume"

  # General Volume Settings
  kms_key_id     = local.kms_key_id
  iops           = local.iops
  throughput     = local.throughput
  final_snapshot = local.final_snapshot

  # Volume
  az_id    = "us-east-1b"
  vol_size = 100

  # Tags
  vol_name          = "data-vol-thatsnotamuffin-es-1-${local.env}"
  region            = local.region
  environment       = local.environment
  supported_app     = "My App"
  supported_service = "Elasticsearch 7.1"
}

module "elasticsearch_volumes_data_2" {
  source = "../modules/volumes/empty_volume"

  # General Volume Settings
  kms_key_id     = local.kms_key_id
  iops           = local.iops
  throughput     = local.throughput
  final_snapshot = local.final_snapshot

  # Volume
  az_id    = "us-east-1c"
  vol_size = 100

  # Tags
  vol_name          = "data-vol-thatsnotamuffin-es-2-${local.env}"
  region            = local.region
  environment       = local.environment
  supported_app     = "My App"
  supported_service = "Elasticsearch 7.1"
}

module "elasticsearch_volumes_data_3" {
  source = "../modules/volumes/empty_volume"

  # General Volume Settings
  kms_key_id     = local.kms_key_id
  iops           = local.iops
  throughput     = local.throughput
  final_snapshot = local.final_snapshot

  # Volume
  az_id    = "us-east-1e"
  vol_size = 100

  # Tags
  vol_name          = "data-vol-thatsnotamuffin-es-3-${local.env}"
  region            = local.region
  environment       = local.environment
  supported_app     = "My App"
  supported_service = "Elasticsearch 7.1"
}
