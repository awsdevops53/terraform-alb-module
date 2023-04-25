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

resource "aws_lb_target_group" "example" {
  name        = "example-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-08fd6d9e9b79fc0c9"
  
  health_check {
    interval            = 30
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "ALBLSNR" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:loadbalancer/app/ALB-lb/2c315b23d48d0bb7"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:targetgroup/example-target-group/cbd18bd63649cd57"
  }
}