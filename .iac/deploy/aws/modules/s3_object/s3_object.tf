
# resource "random_pet" "this" {
#   length = 1
#   keepers = {
#     sse_encrypt = var.sse_encrypt
#   }
# }

resource "aws_s3_bucket_object" "this" {
  for_each = local.website_files

  bucket              = local.bucket
  acl                 = local.acl
  cache_control       = local.cache_control
  content_disposition = local.content_disposition
  content_encoding    = local.content_encoding
  content_language    = local.content_language

  website_redirect = local.website_redirect

  storage_class          = local.storage_class
  server_side_encryption = local.server_side_encryption

  kms_key_id                    = local.kms_key_id
  metadata                      = local.metadata
  force_destroy                 = local.force_destroy
  object_lock_legal_hold_status = local.object_lock_legal_hold_status
  object_lock_mode              = local.object_lock_mode
  object_lock_retain_until_date = local.object_lock_retain_until_date

  # The following attribute info depends on file to be uploaded
  key          = each.key
  source       = "${local.base_folder_path}/${each.key}"
  source_hash  = local.file_hashes[each.key]
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
  # content_type = data.external.get_mime[each.key].result.mime
  # content_type = var.set_auto_content_type ? length(regexall("^.*\\.(.*)", each.value)) > 0 ? lookup(local.extension_to_mime, element(regex("^.*\\.(.*)", each.value), 0), null) : null : var.content_type
  depends_on = [local.module_depends_on]

  tags = local.tags
}
