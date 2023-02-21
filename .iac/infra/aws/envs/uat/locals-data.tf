# data "aws_caller_identity" "current" {}
# data "aws_partition" "current" {}
# data "aws_region" "current" {}

module "common_vars" {
  source = "../../../../_common-vars"
}

locals {

  # account_id = data.aws_caller_identity.current.account_id
  # partition  = data.aws_partition.current.partition
  # region     = data.aws_region.current.name

  zone_name = module.common_vars.zone_name

  site_domain_uat = module.common_vars.site_domain_uat
  subdomain_uat   = module.common_vars.subdomain_uat

  tags = module.common_vars.tags
}
