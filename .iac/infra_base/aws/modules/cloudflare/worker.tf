resource "cloudflare_worker_script" "main_script" {
  account_id = data.cloudflare_accounts.main.accounts[0].id
  name       = "tf-web-test"
  content    = file("${path.module}/../../../../../workers/dist/index.js")
  module     = true
}

resource "cloudflare_worker_route" "catch_all_route" {
  zone_id    = data.cloudflare_zones.domain.zones[0].id
  pattern    = "*${var.zone_name}/*"
  depends_on = [cloudflare_worker_script.main_script]
}
