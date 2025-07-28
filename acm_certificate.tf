# ACM Certificate for quibs.com with subdomains
resource "aws_acm_certificate" "quibs_admin_cert" {
  domain_name               = "quibs.com"
  key_algorithm             = "RSA_2048"
  subject_alternative_names = ["*.quibs.com"]
  validation_method         = "DNS"

  tags = {
    details = "acm certificate for quibs.com with subdomains"
  }

  lifecycle {
    create_before_destroy = true
  }
}
