resource "aws_route53_record" "TXT_DMARC_quibs" {
  name    = "_dmarc.quibs.com"
  records = ["v=DMARC1; p=none; rua=mailto:support@quibs.com; ruf=mailto:support@quibs.com; adkim=s; aspf=s"]
  ttl     = "300"
  type    = "TXT"
  zone_id = aws_route53_zone.quibs.zone_id
}

resource "aws_route53_record" "A_quibs" {
  alias {
    evaluate_target_health = "true"
    name                   = "dualstack.quib-production-lb-1563489702.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
  }

  name    = "quibs.com"
  type    = "A"
  zone_id = aws_route53_zone.quibs.zone_id
}

resource "aws_route53_record" "admin_quibs" {
  zone_id = aws_route53_zone.quibs.zone_id
  name    = "admin.quibs.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.admin_panel.domain_name
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "MX_quibs" {
  name    = "quibs.com"
  records = ["10 mail.s463.sureserver.com"]
  ttl     = "300"
  type    = "MX"
  zone_id = aws_route53_zone.quibs.zone_id
}

resource "aws_route53_record" "NS_quibs" {
  name    = "quibs.com"
  records = ["ns-799.awsdns-35.net.", "ns-1573.awsdns-04.co.uk.", "ns-51.awsdns-06.com.", "ns-1278.awsdns-31.org."]
  ttl     = "172800"
  type    = "NS"
  zone_id = aws_route53_zone.quibs.zone_id
}

resource "aws_route53_record" "SOA_quibs" {
  name    = "quibs.com"
  records = ["ns-799.awsdns-35.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = "900"
  type    = "SOA"
  zone_id = aws_route53_zone.quibs.zone_id
}

resource "aws_route53_record" "TXT_SPF_quibs" {
  name    = "quibs.com"
  records = ["v=spf1 ip4:192.252.146.25 -all"]
  ttl     = "300"
  type    = "TXT"
  zone_id = aws_route53_zone.quibs.zone_id
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.quibs_admin_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.quibs.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}


