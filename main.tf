provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "ALB" {
  name               = "ALB-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-0b7417c037d3b736f", "subnet-08379ffadd1a6be7e"]
  security_groups    = ["sg-12345678"]
}

resource "aws_lb_target_group" "ALBTG" {
  name_prefix        = "ALB-tg"
  port               = 80
  protocol           = "HTTP"
  vpc_id             = "vpc-08fd6d9e9b79fc0c9"
  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "ALBLSNR" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}