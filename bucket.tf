resource "aws_s3_bucket" "admin_panel" {
  bucket = "${var.admin_panel_bucket}-${random_id.suffix.hex}"

  tags = merge(
    local.default_tags,
    {
      details = "S3 bucket for the admin panel angular app build files"
    }
  )
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_public_access_block" "admin_panel" {
  bucket = aws_s3_bucket.admin_panel.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "admin_panel" {
  bucket = aws_s3_bucket.admin_panel.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.admin_panel.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.admin_panel.arn
          }
        }
      }
    ]
  })
}

