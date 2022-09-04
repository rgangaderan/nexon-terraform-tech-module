locals {
  name_prefix = "${var.name}-${var.stage}"
}
###############################################################################
# Application load balancer
###############################################################################
resource "aws_alb" "this_alb" {
  # checkov:skip=CKV2_AWS_28: "Access to this interface is limited only to trusted IPs"
  # checkov:skip=CKV2_AWS_20: "Ensure that ALB redirects HTTP requests into HTTPS ones"

  name               = "${local.name_prefix}-lb"
  internal           = false
  load_balancer_type = "application"

  subnets         = var.network.public_subnet_ids
  security_groups = [aws_security_group.alb_sg.id]

  idle_timeout = 600
  tags         = var.tag_info

  drop_invalid_header_fields = true
  enable_deletion_protection = true

  access_logs {
    bucket  = module.s3_bucket_for_logs.s3_bucket_id
    prefix  = "access-logs"
    enabled = true
  }
}

###############################################################################
# Listener
###############################################################################

resource "aws_alb_listener" "http_listener_service" {
  # checkov:skip=CKV_AWS_103: "Ensure that load balancer is using TLS 1.2"
  count             = local.name_prefix == "" ? 0 : 1
  load_balancer_arn = aws_alb.this_alb.arn

  port     = 80
  protocol = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance_target_group.arn
  }
}

###############################################################################
# TargetGroup Instance
###############################################################################

resource "aws_lb_target_group" "instance_target_group" {
  name        = "${local.name_prefix}-target-gp"
  target_type = var.type
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.network.vpc_id
  health_check {
    healthy_threshold   = var.health_check["healthy_threshold"]
    interval            = var.health_check["interval"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    timeout             = var.health_check["timeout"]
    path                = var.health_check["path"]
    port                = var.health_check["port"]
  }
}
