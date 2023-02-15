# tf-web

## deploy

```bash
aws_assume_role
export CLOUDFLARE_API_TOKEN=$(pass Cloud/cloudflare/Terraform_Token)
cd aws
terraform init
terraform apply
terraform output -raw website_bucket_name > ../website_bucket_name.txt
cd ..
aws s3 cp website/ s3://$(cat website_bucket_name.txt)/ --recursive --profile terraform-admin
```
