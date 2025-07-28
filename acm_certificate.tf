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

resource "aws_acm_certificate_validation" "quibs_cert_validation" {
  certificate_arn         = aws_acm_certificate.quibs_admin_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
