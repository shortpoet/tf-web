output "s3_bucket_object_ids" {
  description = "The list of id of objects."
  value       = module.s3_object_uat.s3_bucket_object_ids
}

output "s3_bucket_object_etags" {
  description = "The list of etag of objects."
  value       = module.s3_object_uat.s3_bucket_object_etags
}

output "s3_bucket_object_version_ids" {
  description = "The list of version_id of objects."
  value       = module.s3_object_uat.s3_bucket_object_version_ids
}

output "s3_bucket_object_keys_ids" {
  description = "The list of map containing id and aws s3 key of objects."
  value       = module.s3_object_uat.s3_bucket_object_keys_ids
}
