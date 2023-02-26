# resource "null_resource" "cloudflare_worker" {
#   count = var.worker_script_root_dir != null ? 1 : 0
#   triggers = {
#     zone_name              = var.zone_name
#     cname_name             = var.cname_name
#     cname_value_endpoint   = var.cname_value_endpoint
#     worker_script_name     = var.worker_script_name
#     worker_script_path     = var.worker_script_path
#     worker_script_root_dir = var.worker_script_root_dir
#   }
#   provisioner "local-exec" {
#     working_dir = var.worker_script_root_dir
#     command     = "npm run build"
#   }
# }

data "external" "build_node" {
  count       = var.worker_script_root_dir != null ? 1 : 0
  working_dir = var.worker_script_root_dir
  program = [
    "bash",
    "${abspath(path.root)}/../../modules/cloudflare/build_worker.sh",
  ]
  query = {
    worker_script_path = var.worker_script_path
  }
}

data "local_file" "worker_script" {
  count    = var.worker_script_path != null ? 1 : 0
  filename = data.external.build_node[0].result["worker_script_path"]
}
resource "cloudflare_worker_script" "main_script" {
  count      = var.worker_script_path != null ? 1 : 0
  account_id = data.cloudflare_accounts.main.accounts[0].id
  name       = var.worker_script_name
  content    = data.local_file.worker_script[0].content
  module     = true
  depends_on = [
    data.local_file.worker_script
  ]
}

resource "cloudflare_worker_route" "catch_all_route" {
  count   = var.worker_script_name != null ? 1 : 0
  zone_id = data.cloudflare_zones.domain.zones[0].id
  pattern = "${var.cname_name}.${var.zone_name}/*"
  # pattern    = "*${var.zone_name}/*"
  depends_on = [
    cloudflare_worker_script.main_script
  ]
  script_name = var.worker_script_name
}
