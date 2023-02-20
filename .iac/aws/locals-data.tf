# data "aws_caller_identity" "current" {}
# data "aws_partition" "current" {}
# data "aws_region" "current" {}

module "common_vars" {
  source = "../_common-vars"
}

locals {

  # account_id = data.aws_caller_identity.current.account_id
  # partition  = data.aws_partition.current.partition
  # region     = data.aws_region.current.name

  zone_name = module.common_vars.zone_name

  site_domain_root = module.common_vars.site_domain
  site_domain_dev  = module.common_vars.site_domain_dev

  tags = module.common_vars.tags
}
