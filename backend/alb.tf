resource "aws_lb" "tododot" {
  name               = "tododot"
  load_balancer_type = "application"
  internal           = false
  idle_timeout       = 60

  subnets = [
    aws_subnet.public_0.id,
    aws_subnet.public_1.id,
  ]

  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    enabled = true
  }

  security_groups = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id,
  ]
}

data "aws_elb_service_account" "alb_log" {}

output "alb_dns_name" {
  value = aws_lb.tododot.dns_name
}

resource "aws_lb_listener" "redirect" {
  load_balancer_arn = aws_lb.tododot.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.tododot.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.api.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "request over https"
      status_code  = 200
    }
  }
}

resource "aws_lb_target_group" "tododot" {
  name                 = "tododot"
  target_type          = "ip"
  vpc_id               = aws_vpc.tododot.id
  port                 = 8000
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    interval            = 120
    path                = "/healthcheck"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 15
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = 200
  }

  depends_on = [aws_lb.tododot]
}

resource "aws_lb_listener_rule" "tododot" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tododot.arn
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}
