provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "ALB" {
  name               = "ALB-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-0b7417c037d3b736f", "subnet-075e1d443a1a2ae25"]
  security_groups    = ["sg-0c081e572fcbb6b95"]
}

resource "aws_lb_target_group" "example" {
  name        = "alb-target-group"
  port        = 80
  protocol    = "TCP"
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

resource "aws_lb_listener" "ALB-LSNR" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:loadbalancer/app/ALB-lb/d820158ed819f7cd"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:targetgroup/alb-target-group/f4d6c2d18b77662f"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment_test1" {
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:targetgroup/alb-target-group/f4d6c2d18b77662f"
    target_id        = "i-000852422c66c4782, i-0c71a23a8eb7b528a" 
    port             = 80
}