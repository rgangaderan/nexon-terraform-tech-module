locals {
  name_prefix = "${var.name}_${var.stage}"
}

resource "aws_instance" "ec2_private" {

  # checkov:skip=CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
  # checkov:skip=CKV_AWS_135: "Ensure that EC2 is EBS optimized"
  # checkov:skip=CKV_AWS_126: "Ensure that detailed monitoring is enabled for EC2 instances"
  # checkov:skip=CKV_AWS_8: "Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted"
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
