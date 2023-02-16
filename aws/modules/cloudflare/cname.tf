data "cloudflare_zones" "domain" {
  filter {
    name = var.zone_name
  }
}

resource "cloudflare_record" "cname" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.cname_name
  value   = var.cname_value_endpoint
  type    = "CNAME"

  ttl     = var.cname_ttl
  proxied = var.cname_proxied
}
