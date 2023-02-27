data "cloudflare_zones" "domain" {
  filter {
    name = var.zone_name
  }
}
data "cloudflare_accounts" "main" {
  name = "Soriano.carlos@gmail.com's Account"
}
