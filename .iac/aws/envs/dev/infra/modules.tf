module "s3_dev" {
  source                  = "../../../modules/s3"
  site_domain_bucket_name = local.site_domain_dev
  tags                    = local.tags
}

module "cloudflare_dev" {
  source               = "../../../modules/cloudflare"
  zone_name            = local.zone_name
  cname_name           = local.subdomain_dev
  cname_value_endpoint = module.s3_dev.website_endpoint
}
