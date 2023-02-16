# tf-web

## deploy

```bash
aws_assume_role
export CLOUDFLARE_API_TOKEN=$(pass Cloud/cloudflare/Terraform_Token)
cd aws
terraform init
terraform apply
terraform output -raw site_domain_root > ../site_domain_root.txt
terraform output -raw site_domain_dev > ../site_domain_dev.txt
cd ..
aws s3 cp website/ s3://$(cat site_domain_root.txt)/ --recursive --profile terraform-admin
aws s3 cp shortpoet_site/ s3://$(cat site_domain_dev.txt)/ --recursive --profile terraform-admin
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
