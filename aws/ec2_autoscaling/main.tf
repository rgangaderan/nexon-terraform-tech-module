locals {
  name_prefix = "${var.name}-${var.stage}"

  tag_info = [
    { "key" : "Environment", "value" : "${var.stage}", propagate_at_launch : "true" },
    { "key" : "PlatformOwner", "value" : "${var.name}-${var.stage}", propagate_at_launch : "true" },
    { "key" : "Name", "value" : "${var.name}-${var.stage}", propagate_at_launch : "true" },
  ]
}

resource "aws_launch_template" "nexon-vms" {

  # checkov:skip=CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"

  name                   = "${local.name_prefix}-ec2"
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
  name                = "${local.name_prefix}-aws_autoscaling_group"
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.vpc_zone_identifier
  load_balancers      = var.load_balancers
  launch_template {
    name = aws_launch_template.nexon-vms.name
  }
  tags = local.tag_info
}
