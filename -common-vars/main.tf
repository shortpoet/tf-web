terraform {
  required_version = ">= 0.13.5"
}
locals {
  site_domain = "marshmallowmeat.com"

  tags = {
    Terraform = "true"
    Project   = "tf-web"
  }

}

output "site_domain" {
  value = local.site_domain
}

output "tags" {
  value = local.tags
}
