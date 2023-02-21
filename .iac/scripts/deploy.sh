#!/usr/bin/env bash

set -e

provider="${1:-aws}"
env="${2:-dev}"

help_me() {
  echo "Usage: $0 [provider] [env]"
  echo "  provider: aws, gcp, azure"
  echo "  env: dev, prod"
  exit 0
}
[[ "$*" == *--help* ]] && help_me

active_dir=$(pwd)
script_dir=$(dirname "$0")
repo_root=$(git rev-parse --show-toplevel)

. "$script_dir/aws_assume_role.sh"

aws_profile='terraform-admin'

[[ "$provider" != "aws" ]] && {
  echo "Only AWS is supported at this time"
  help_me
  exit 1
}

login_aws() {
    echo "Provider credentials not found -> assuming role"
    aws_assume_role
}

provider_credentials_check() {
  CLOUDFLARE_API_TOKEN=$(pass Cloud/cloudflare/Terraform_Token)
  export CLOUDFLARE_API_TOKEN
  if [[ "$provider" == "aws" ]]; then
    aws sts get-caller-identity --profile "$aws_profile" >/dev/null || login_aws
  fi
}

provider_credentials_check

echo "Deploying to $provider/$env"

cd "$repo_root/.iac/$provider/envs/$env/infra"
# terraform init
# terraform apply
site_domain=$(terraform output -raw site_domain)
website_bucket_id=$(terraform output -json s3 | jq -r .website_bucket_id)
if [[ "$env" == "prod" ]]; then
  cd "$repo_root/tic_tac_toe"
else
  cd "$repo_root/shortpoet_site"
fi

if [[ "$provider" == "aws" ]]; then
  aws s3 cp --recursive --acl public-read --profile "$aws_profile" . "s3://$website_bucket_id"
fi

cd "$active_dir"
