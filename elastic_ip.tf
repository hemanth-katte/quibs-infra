resource "aws_eip" "quib_production" {
  instance = aws_instance.quib_prod.id
  tags = merge(
    local.default_tags,
    {
      Name = "QuipProductionEIP"
    }
  )
}
