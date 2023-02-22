data "terraform_remote_state" "s3_bucket_uat" {
  backend = "s3"
  config = {
    region         = "us-east-1"
    bucket         = "341864192726-terraform-backend"
    key            = "tf-web/infra/aws/envs/uat/terraform.tfstate"
    dynamodb_table = "terraform-backend-lock"
    profile        = "terraform-admin"
    encrypt        = "true"
  }
}

module "common_vars" {
  source = "../../../../_common-vars"
}

module "s3_object_uat" {
  source = "../../modules/s3_object"
  bucket = data.terraform_remote_state.s3_bucket_uat.outputs.s3.website_bucket_id

  acl              = "public-read"
  cache_control    = "max-age=31536000, immutable"
  base_folder_path = "${path.module}/../../../../../shortpoet_site"
  force_destroy    = true

  tags = module.common_vars.tags
}
