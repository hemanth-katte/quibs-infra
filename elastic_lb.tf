resource "aws_lb" "quib_production" {
  name               = "Quib-Production-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    "sg-0e37fcbbb1d58cf85",
    "sg-0938a3b2c1155d6b8"
  ]
  subnets = [
    "subnet-05404b2d927691027",
    "subnet-05a687e666379fe29",
    "subnet-075f6726de4eae9cd",
    "subnet-082957277bd96d4b1",
    "subnet-092f1c398bbf9020a",
    "subnet-0d2ea4d0ac47642a4"
  ]

  ip_address_type            = "ipv4"
  enable_deletion_protection = false
  tags = merge(
    local.default_tags,
    {
      Name = "Quib-Production-LB"
    }
  )
}

resource "aws_lb_listener" "quib_http" {
  load_balancer_arn = aws_lb.quib_production.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }
}

resource "aws_lb_listener" "quib_https" {
  load_balancer_arn = aws_lb.quib_production.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = "arn:aws:acm:us-east-1:812027291545:certificate/29570e33-0377-480a-a86e-fcc6b598be0d"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.quib_production.arn
        weight = 1
      }

      stickiness {
        enabled  = false
        duration = 3600
      }
    }
  }
}

resource "aws_lb_target_group" "quib_production" {
  name     = "Quib-Production"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-025359e858376592f"

  health_check {
    enabled             = true
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    port                = "traffic-port"
  }

  target_type      = "instance"
  ip_address_type  = "ipv4"
  protocol_version = "HTTP1"

  tags = merge(
    local.default_tags,
    {
      Name = "Quib-Production"
    }
  )
}

resource "aws_lb_target_group_attachment" "quib_production_ec2" {
  target_group_arn = aws_lb_target_group.quib_production.arn
  target_id        = aws_instance.quib_prod.id
  port             = 80
}

