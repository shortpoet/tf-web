module "s3_root" {
  source                  = "../../../modules/s3"
  site_domain_bucket_name = local.site_domain_root
  tags                    = local.tags
}

module "cloudflare_root" {
  source               = "../../../modules/cloudflare"
  zone_name            = local.zone_name
  cname_name           = local.site_domain_root
  cname_value_endpoint = module.s3_root.website_endpoint
}

module "s3_root_www" {
  source                   = "../../../modules/s3"
  site_domain_bucket_name  = "www.${local.site_domain_root}"
  redirect_all_requests_to = local.site_domain_root
  tags                     = local.tags
}

module "cloudflare_root_www" {
  source               = "../../../modules/cloudflare"
  zone_name            = local.zone_name
  cname_name           = "www"
  cname_value_endpoint = local.site_domain_root
}
