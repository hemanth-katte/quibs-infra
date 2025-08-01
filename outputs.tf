output "aws_instance_quib_prod_id" {
  value = aws_instance.quib_prod.id
}

output "acm_dns_validation_records" {
  value = aws_acm_certificate.quibs_admin_cert.domain_validation_options
}
