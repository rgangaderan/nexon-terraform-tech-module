locals {
  name_prefix = "${var.name}-${var.stage}"
}
###############################################################################
# Application load balancer

resource "aws_alb" "this_alb" {
  # checkov:skip=CKV2_AWS_28: "Access to this interface is limited only to trusted IPs"
  # checkov:skipt=CKV2_AWS_20: "Ensure that ALB redirects HTTP requests into HTTPS ones"
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

resource "aws_alb_listener" "http_listener_service" {
  # checkov:skip=CKV_AWS_103: "Ensure that load balancer is using TLS 1.2"
  count             = local.name_prefix == "" ? 0 : 1
  load_balancer_arn = aws_alb.this_alb.arn


  port     = 80
  protocol = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "No services deployed"
      status_code  = "200"
    }
  }
}
