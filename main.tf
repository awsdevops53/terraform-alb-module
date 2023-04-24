provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "ALB" {
  name               = "ALB-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-0b7417c037d3b736f", "subnet-08379ffadd1a6be7e"]
  security_groups    = ["sg-0c081e572fcbb6b95"]
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
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:loadbalancer/app/ALB-lb/974d58b4544e39e9"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:targetgroup/ALB-tg20230424064929632600000001/2069cce7616e00e0"
  }
}

resource "aws_lb_target_group_attachment" "ALBTG" {
  target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:targetgroup/ALB-tg20230424064929632600000001/2069cce7616e00e0"
  target_id        = i-0b7120b20f0e8990f
  port             = 80
}
