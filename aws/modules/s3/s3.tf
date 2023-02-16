locals {
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
        # Condition = {
        #   StringEquals = {
        #     "aws:SourceIp" = [
        #       "(add all IPs listed at https://www.cloudflare.com/ips)",
        #       "https://${var.site_domain}",
        #     ]
        #   }
        # }
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
