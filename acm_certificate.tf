resource "aws_acm_certificate" "quibs_cert" {
  domain_name   = "quibs.com"
  key_algorithm = "RSA_2048"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  subject_alternative_names = ["quibs.com"]
  validation_method         = "EMAIL"
  tags = merge(
    local.default_tags,
    {
      "Description" = "ACM certificate for quibs.com"
      "SpecialNote" = "Imported from ClickOps via Terraformer"
    }
  )
}
