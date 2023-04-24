provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "ALB" {
  name               = "ALB-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-0b7417c037d3b736f", "subnet-08379ffadd1a6be7e"]
  security_groups    = ["sg-094ac35818b33b834"]
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