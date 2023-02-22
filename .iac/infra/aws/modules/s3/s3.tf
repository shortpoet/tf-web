locals {
  cloudflare_ips = [
    "173.245.48.0/20",
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "141.101.64.0/18",
    "108.162.192.0/18",
    "190.93.240.0/20",
    "188.114.96.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17",
    "162.158.0.0/15",
    "104.16.0.0/12",
    "172.64.0.0/13",
    "131.0.72.0/22",
    "2400:cb00::/32",
    "2606:4700::/32",
    "2803:f800::/32",
    "2405:b500::/32",
    "2405:8100::/32",
    "2a06:98c0::/29",
    "2c0f:f248::/32"
  ]
  tags = merge(
    {
      Name = var.site_domain_bucket_name
    },
    var.tags,
  )
}

resource "aws_s3_bucket" "site" {
  bucket = var.site_domain_bucket_name
  # acl    = "private"
  tags = local.tags
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id


  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

  # routing_rules = jsonencode([
  #   {
  #     Redirect = {
  #       ReplaceKeyPrefixWith = "/"
  #       HttpRedirectCode     = "301"
  #     }
  #     Condition = {
  #       KeyPrefixEquals = "index.html"
  #     }
  #   },
  #   {
  #     Redirect = {
  #       ReplaceKeyPrefixWith = ""
  #       HttpRedirectCode     = "301"
  #     }
  #     Condition = {
  #       KeyPrefixEquals = "docs/"
  #     }
  #   },
  # ])

}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.site.id

  cors_rule {
    # allowed_headers = ["*"]
    # allowed_methods = ["PUT", "POST"]
    # allowed_origins = ["https://s3-website-test.hashicorp.com"]
    # expose_headers  = ["ETag"]
    # max_age_seconds = 3000
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.site_domain_bucket_name}"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.site.arn,
          "${aws_s3_bucket.site.arn}/*",
        ],
        # Condition = {
        #   StringEquals = {
        #     "aws:Referer" = [
        #       "https://${var.site_domain}/*",
        #       "https://${var.site_domain}",
        #     ]
        #   }
        # }
        Condition = {
          StringEquals = {
            "aws:SourceIp" = local.cloudflare_ips
          }
        }
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "redirect" {
  count  = var.redirect_all_requests_to != null ? 1 : 0
  bucket = aws_s3_bucket.site.id

  redirect_all_requests_to {
    host_name = var.redirect_all_requests_to
  }
}
