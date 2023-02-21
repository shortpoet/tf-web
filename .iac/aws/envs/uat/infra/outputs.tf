output "site_domain" {
  value = local.site_domain_uat
}

output "s3" {
  value = module.s3_uat
}

output "cloudflare" {
  value = module.cloudflare_uat
}
