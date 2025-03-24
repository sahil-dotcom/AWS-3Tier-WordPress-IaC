resource "aws_lb" "main-lb" {
  name               = "${var.projectname}-alb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  tags = {
    Name        = "${var.projectname}-alb"
    Enivronment = var.environment
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.projectname}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 10
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}