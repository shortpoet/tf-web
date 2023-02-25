terraform {
  required_version = ">= 1.3.0"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "litos-terraform-backend"
    key            = "tf-web/infra_app/aws/envs/prod/terraform.tfstate"
    dynamodb_table = "terraform-backend-lock"
    profile        = "terraform-admin"
    encrypt        = "true"
  }
}
