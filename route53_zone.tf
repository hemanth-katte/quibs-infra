resource "aws_route53_zone" "quibs" {
  force_destroy = "false"
  name          = "quibs.com"
  tags = merge(
    local.default_tags,
    {
      "Name"        = "quibs.com"
      "Description" = "Route53 zone for quibs.com"
      "SpecialNote" = "Imported from ClickOps via Terraformer"
    }
  )
}
