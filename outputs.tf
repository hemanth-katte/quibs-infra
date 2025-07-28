output "aws_route53_record_TXT_DMARC_quibs_id" {
  value = aws_route53_record.TXT_DMARC_quibs.id
}

output "aws_route53_record_A_quibs_id" {
  value = aws_route53_record.A_quibs.id
}

output "aws_route53_record_MX_quibs_id" {
  value = aws_route53_record.MX_quibs.id
}

output "aws_route53_record_NS_quibs_id" {
  value = aws_route53_record.NS_quibs.id
}

output "aws_route53_record_SOA_quibs_id" {
  value = aws_route53_record.SOA_quibs.id
}

output "aws_route53_record_TXT_SPF_quibs_id" {
  value = aws_route53_record.TXT_SPF_quibs.id
}

output "aws_route53_zone_quibs_id" {
  value = aws_route53_zone.quibs.id
}

output "aws_instance_quib_prod_id" {
  value = aws_instance.quib_prod.id
}

output "aws_instance_quib_admin_id" {
  value = aws_instance.quib_admin.id
}

output "aws_instance_quib_test_id" {
  value = aws_instance.quib_test.id
}

output "acm_dns_validation_records" {
  value = aws_acm_certificate.quibs_admin_cert.domain_validation_options
}
