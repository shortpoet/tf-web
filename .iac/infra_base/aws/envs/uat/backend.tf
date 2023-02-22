terraform {
  required_version = ">= 0.13.5"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "341864192726-terraform-backend"
    key            = "tf-web/base_infra/aws/envs/uat/terraform.tfstate"
    dynamodb_table = "terraform-backend-lock"
    profile        = "terraform-admin"
    encrypt        = "true"
  }
}
