locals {
  name_prefix = "${var.name}_${var.stage}"
}

resource "aws_instance" "ec2_private" {
  count                  = var.instance_count
  ami                    = var.image_id
  instance_type          = lookup(var.instance_type, var.stage, "instance type not allowed!")
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups
  user_data              = base64encode(var.user_data)
  iam_instance_profile   = var.iam_instance_profile

  tags = var.tag_info

}
