output "site_domain" {
  value = local.site_domain_dev
}

output "s3" {
  value = module.s3_dev
}

output "cloudflare" {
  value = module.cloudflare_dev
}
