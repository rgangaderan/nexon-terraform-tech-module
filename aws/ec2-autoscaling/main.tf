locals {
  name_prefix = "${var.name}-${var.stage}"
}
resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
}

resource "aws_launch_template" "nexon-vms" {

  # checkov:skip=CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"

  name                   = "${local.name_prefix}-ec2-${random_string.random.result}"
  image_id               = var.image_id
  instance_type          = lookup(var.instance_type, var.stage, "instance type not allowed!")
  key_name               = var.key_name
  update_default_version = true
  user_data              = base64encode(var.user_data)

  iam_instance_profile {
    name = var.iam_instance_profile
  }
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.volume_size
      delete_on_termination = true
      encrypted             = true
      volume_type           = var.volume_type
    }
  }
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    subnet_id                   = var.subnet_id
    security_groups             = var.security_groups
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "hosts" {
  name                = "${local.name_prefix}-${random_string.random.result}"
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.vpc_zone_identifier
  load_balancers      = var.load_balancers
  target_group_arns   = var.target_group_arns
  launch_template {
    name = aws_launch_template.nexon-vms.name
  }
  tag {
    key                 = "Name"
    value               = local.name_prefix
    propagate_at_launch = true
  }
}
