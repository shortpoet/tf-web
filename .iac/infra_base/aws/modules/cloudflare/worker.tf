resource "cloudflare_worker_script" "main_script" {
  count      = var.worker_script_name != null ? 1 : 0
  account_id = data.cloudflare_accounts.main.accounts[0].id
  name       = var.worker_script_name
  content    = var.worker_script
  module     = true
}

resource "cloudflare_worker_route" "catch_all_route" {
  count   = var.worker_script_name != null ? 1 : 0
  zone_id = data.cloudflare_zones.domain.zones[0].id
  pattern = "${var.cname_name}.${var.zone_name}/*"
  # pattern    = "*${var.zone_name}/*"
  depends_on  = [cloudflare_worker_script.main_script]
  script_name = var.worker_script_name
}
