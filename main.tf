provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "ALB" {
  name                     = "alb-rana"
  load_balancer_type       = "application"
  subnets                  = ["subnet-0b7417c037d3b736f","subnet-075e1d443a1a2ae25"]
  security_groups          = ["sg-0c081e572fcbb6b95"]
 }

resource "aws_lb_target_group" "targetgroup1"  {
     name                  = "alb-tg"
      protocol             = "HTTP"
      target_type          = "ip"
      port                 = "80"
      vpc_id               = "vpc-08fd6d9e9b79fc0c9"
      health_check{
        path                 = "/"
      }
 }

resource "aws_lb_listener" "ALB-LSNR" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:loadbalancer/app/alb-rana/39231981d7f156d9"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:238393102293:targetgroup/alb-tg/c825aaad54d10fdf"
  }
}

resource "aws_lb_target_group_attachment" "my_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = "172.31.53.139, 172.31.91.234"
  port             = 80
}