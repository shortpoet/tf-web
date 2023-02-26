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
- [pr API trigger - gh issue](https://github.com/actions/download-artifact/issues/3#issuecomment-1017141067)
- [pr API trigger- Keeping your GitHub Actions and workflows secure Part 1: Preventing pwn requests](https://securitylab.github.com/research/github-actions-preventing-pwn-requests/)
- [action download artifact](https://github.com/dawidd6/action-download-artifact)
- [set-cache-control-for-entire-s3-bucket-automatically-using-bucket-policies](https://stackoverflow.com/questions/10435334/set-cache-control-for-entire-s3-bucket-automatically-using-bucket-policies)
- [mime types spec](https://www.iana.org/assignments/media-types/media-types.xhtml)
- [blog - mime types w/ external data source/tool](https://www.tangramvision.com/blog/abusing-terraform-to-upload-static-websites-to-s3)
- [gh - s3 object module](https://github.com/chandan-singh/terraform-aws-s3-object-folder)
- [gh - s3 object module](https://github.com/Lupus-Metallum/terraform-aws-s3-static-website)
- [blog - cache control](https://csswizardry.com/2019/03/cache-control-for-civilians/)

## deploy

```bash
aws_assume_role
export CLOUDFLARE_API_TOKEN=$(pass Cloud/cloudflare/Terraform_Token)
export CLOUDFLARE_ACCOUNT_ID=$(pass Cloud/cloudflare/account_id)
cd aws
terraform init
terraform apply
terraform output -raw site_domain_root > ../site_domain_root.txt
terraform output -raw site_domain_dev > ../site_domain_dev.txt
cd ..
aws s3 cp website/ s3://$(cat site_domain_root.txt)/ --recursive --profile terraform-admin
aws s3 cp shortpoet_site/ s3://$(cat site_domain_dev.txt)/ --recursive --profile terraform-admin
```

## tags

```bash
git tag -a v0.0.1 -m "first release"
git push --follow-tags
git tag -d v0.0.1
git push --delete origin v0.0.1
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
