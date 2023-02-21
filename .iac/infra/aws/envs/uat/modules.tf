module "s3_uat" {
  source                  = "../../modules/s3"
  site_domain_bucket_name = local.site_domain_uat
  tags                    = local.tags
}

module "cloudflare_uat" {
  source               = "../../modules/cloudflare"
  zone_name            = local.zone_name
  cname_name           = local.subdomain_uat
  cname_value_endpoint = module.s3_uat.website_endpoint
}
