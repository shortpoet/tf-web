output "site_domain_root" {
  value = local.site_domain_root
}

output "site_domain_dev" {
  value = local.site_domain_dev
}

output "cloudflare_root" {
  value = module.cloudflare_root
}

output "cloudflare_root_www" {
  value = module.cloudflare_root_www
}

output "cloudflare_dev" {
  value = module.cloudflare_dev
}

output "s3_root" {
  value = module.s3_root
}

output "s3_root_www" {
  value = module.s3_root_www
}

output "s3_dev" {
  value = module.s3_dev
}
