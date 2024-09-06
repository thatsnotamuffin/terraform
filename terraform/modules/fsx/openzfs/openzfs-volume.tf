resource "aws_fsx_openzfs_volume" "volume" {
  for_each = { for k, v in var.volumes : k => v }

  copy_tags_to_snapshots = try(each.value.copy_tags_to_snapshots, null)
  data_compression_type  = try(each.value.data_compression_type, null)
  delete_volume_options  = try(each.value.delete_volume_options, null)
  name                   = try(each.value.name, null)

  dynamic "origin_snapshot" {
    for_each = try([each.value.origin_snapshot], [])

    content {
      copy_strategy = origin_snapshot.value.copy_strategy
      snapshot_arn  = origin_snapshot.value.snapshot_arn
    }
  }

  parent_volume_id                 = try(each.value.parent_volume_id, aws_fsx_openzfs_file_system.openzfs.root_volume_id)
  read_only                        = try(each.value.delete_volume_options, null)
  record_size_kib                  = try(each.value.delete_volume_options, null)
  storage_capacity_quota_gib       = try(each.value.delete_volume_options, null)
  storage_capacity_reservation_gib = try(each.value.delete_volume_options, null)

  dynamic "user_and_group_quotas" {
    for_each = try(each.value.user_and_group_quotas, [])

    content {
      id                         = user_and_group_quotas.value.id
      storage_capacity_quota_gib = user_and_group_quotas.value.storage_capacity_quota_gib
      type                       = user_and_group_quotas.value.type
    }
  }

  volume_type = "OPENZFS"
}
