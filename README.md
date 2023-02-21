# tf-web

## refs

- [Terraform: AWS: S3: Static Website Hosting](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#static-website-hosting)
- [](https://github.com/Pwd9000-ML/Azure-Terraform-Deployments)
- [GH Security](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions#understanding-the-risk-of-script-injections)
- [action script](https://github.com/actions/github-script)
- [tf gh actions](https://github.com/dflook/terraform-github-actions)
- [changed files](https://dev.to/scienta/get-changed-files-in-github-actions-1p36)
- [blog](https://gaunacode.com/deploying-terraform-at-scale-with-github-actions)
- [blog](https://blog.testdouble.com/posts/2021-12-07-elevate-your-terraform-workflow-with-github-actions/)
- 

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
