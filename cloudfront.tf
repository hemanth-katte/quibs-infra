resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "admin-panel-oac"
  description                       = "OAC for the admin panel S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "admin_panel" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.admin_panel.bucket_regional_domain_name
    origin_id   = "s3-admin-panel"

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    target_origin_id = "s3-admin-panel"

    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = merge(
    local.default_tags,
    {
      details = "CloudFront distribution for the admin panel S3 bucket"
    }
  )

}
