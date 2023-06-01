data "cloudflare_ip_ranges" "cloudflare" {}
data "aws_canonical_user_id" "current" {}
# data "aws_caller_identity" "current" {}
data "aws_iam_role" "terraform_admin" {
  name = "terraform-admin"
}
data "aws_iam_user" "admin" {
  user_name = "Administrator"
}
locals {
  # caller_arn           = "arn:aws:iam::${data.aws_caller_identity.current.account_id}"
  cloudflare_ip_ranges = concat(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks, data.cloudflare_ip_ranges.cloudflare.ipv6_cidr_blocks)
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

resource "aws_s3_bucket_website_configuration" "redirect" {
  count  = var.redirect_all_requests_to != null ? 1 : 0
  bucket = aws_s3_bucket.site.id

  redirect_all_requests_to {
    host_name = var.redirect_all_requests_to
  }
}


resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  dynamic "redirect_all_requests_to" {
    for_each = var.redirect_all_requests_to != null ? [var.redirect_all_requests_to] : []
    content {
      host_name = redirect_all_requests_to.value
    }
  }

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

  # acl = "private"
  # acl = "public-read"

  access_control_policy {
    # grant {
    #   grantee {
    #     type = "Group"
    #     uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
    #   }
    #   permission = "READ"
    # }

    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }

    # grant {
    #   grantee {
    #     type = "Group"
    #     uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
    #   }
    #   permission = "READ_ACP"
    # }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }



}


locals {
  public_read_get_object = {
    Sid       = "PublicReadGetObject"
    Effect    = "Allow"
    Principal = "*"
    Action    = "s3:GetObject"
    Resource = [
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
      IpAddress = {
        "aws:SourceIp" = local.cloudflare_ip_ranges
      }
    }
  }
  restrict_to_cloudflare_ips = {
    Sid    = "RestrictToCloudflareIPs"
    Effect = "Deny"
    Action = "s3:*"
    Resource = [
      aws_s3_bucket.site.arn,
      "${aws_s3_bucket.site.arn}/*",
    ]
    # NotPrincipal = {
    #   AWS = [
    #     "${local.caller_arn}:root",
    #     "${local.caller_arn}:user/Administrator",
    #   ]
    # }
    Principal = "*"
    Condition = {
      NotIpAddress = {
        "aws:SourceIp" = local.cloudflare_ip_ranges
      },
      StringNotLike = {
        "aws:userId" = [
          data.aws_iam_user.admin.user_id,
          "${data.aws_iam_role.terraform_admin.unique_id}:*",
        ]
      }
    }
  }

}
resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      local.public_read_get_object,
      local.restrict_to_cloudflare_ips,
    ]
  })
}
