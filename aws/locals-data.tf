data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

module "common_vars" {
  source = "../-common-vars"
}

locals {

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  region     = data.aws_region.current.name

  site_domain = module.common_vars.site_domain

  tags = module.common_vars.tags
}
