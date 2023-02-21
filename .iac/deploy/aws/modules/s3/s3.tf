

resource "aws_s3_object" "this" {
  for_each = fileset(var.file_path, "**")

  bucket        = var.bucket_id
  acl           = var.acl
  cache_control = var.cache_control


  content_language = var.content_language

  storage_class          = var.storage_class
  server_side_encryption = random_pet.this.keepers["sse_encrypt"] ? "AES256" : null



  key          = each.value
  source       = "${var.file_path}/${each.value}"
  etag         = filemd5("${var.file_path}/${each.value}")
  content_type = lookup(jsondecode(file("${path.module}/src/mime.json")), regex("\\.[^.]+$", each.value), null)


  lifecycle {
    replace_triggered_by = [
      random_pet.this
    ]
  }
}
