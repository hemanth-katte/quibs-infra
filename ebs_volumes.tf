resource "aws_ebs_volume" "quib_production" {
  availability_zone = "us-east-1a"
  size              = 30
  type              = "gp2"
  snapshot_id       = "snap-0a67481997c390f4e"
  tags = merge(
    local.default_tags,
    {
      Name = "VolumeFor-i-03c4cda49671c9c42"
    }
  )
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_volume_attachment" "quib_production_attach" {
  device_name  = "/dev/sda1"
  volume_id    = aws_ebs_volume.quib_production.id
  instance_id  = "i-03c4cda49671c9c42"
  force_detach = false
}
