output "website_bucket_id" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.site.id
}

output "website_endpoint" {
  description = "Bucket endpoint"
  value       = aws_s3_bucket_website_configuration.site.website_endpoint
}

output "website_domain" {
  description = "Website endpoint"
  value       = aws_s3_bucket_website_configuration.site.website_domain
}

output "tags" {
  value = aws_s3_bucket.site.tags
}
