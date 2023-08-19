resource "aws_lb" "tw_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.aws_sg_id]
  subnets            = var.aws_subnet_ids

  access_logs {
    bucket  = "tw-alb-log"
    prefix  = "alb-log"
    enabled = true
  }
}

resource "aws_lb_listener" "tw_alb_listener" {
  load_balancer_arn = aws_lb.tw_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tw_target_group.arn
  }
}

resource "aws_lb_target_group" "tw_target_group" {
  name     = var.alb_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.aws_vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/health"
  }
}

resource "aws_lb_target_group_attachment" "tw_target_group_attachment" {
  count            = length(var.aws_ec2_instance_ids)
  target_group_arn = aws_lb_target_group.tw_target_group.arn
  target_id        = var.aws_ec2_instance_ids[count.index]
  port             = 8080
}