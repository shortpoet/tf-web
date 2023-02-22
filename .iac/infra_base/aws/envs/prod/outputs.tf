output "site_domain" {
  value = local.site_domain_root
}

output "s3" {
  value = module.s3_root
}

output "cloudflare" {
  value = module.cloudflare_root
}

output "s3_www" {
  value = module.s3_root_www
}

output "cloudflare_www" {
  value = module.cloudflare_root_www
}
