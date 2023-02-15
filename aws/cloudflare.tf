# data "cloudflare_zones" "domain" {
#   filter {
#     status = "active"
#   }
# }

# data "cloudflare_zone" "marshmallow" {
#   zone_id = "45371d5e2e41b9575d6e48c8c614d895"
# }

# output "cloudflare_zones" {
#   value = data.cloudflare_zones.domain
# }

# output "cloudflare_zone" {
#   value = data.cloudflare_zone.marshmallow
# }

data "cloudflare_zones" "domain" {
  filter {
    name = local.site_domain
  }
}

resource "cloudflare_record" "site_cname" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = local.site_domain
  value   = aws_s3_bucket_website_configuration.site.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "www"
  value   = local.site_domain
  type    = "CNAME"

  ttl     = 1
  proxied = true
}
