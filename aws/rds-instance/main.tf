locals {
  name_prefix = "${var.name}-${var.stage}"
}

module "random" {
  source = "../random-string/"
}

#####################################################
# DB Subnet Group
#####################################################
resource "aws_db_subnet_group" "default" {
  name       = "${local.name_prefix}-${module.random.result}"
  subnet_ids = var.private_subnet_ids

  tags = var.tag_info
}

#####################################################
# RDS Instance
#####################################################
resource "aws_db_instance" "database" {
  # checkov:skip=CKV_AWS_157: "Ensure that RDS instances have Multi-AZ enabled"
  # checkov:skip=CKV_AWS_118: "Ensure that enhanced monitoring is enabled for Amazon RDS instances"
  identifier                 = "${local.name_prefix}-${module.random.result}"
  allocated_storage          = var.db.storage
  engine                     = var.db.engine
  engine_version             = var.db.engine_version
  instance_class             = var.db.instance_class
  name                       = var.db.database_name
  username                   = var.database_username
  password                   = var.database_password
  parameter_group_name       = var.db.parameter_group_name
  storage_encrypted          = true
  skip_final_snapshot        = true
  auto_minor_version_upgrade = true
  db_subnet_group_name       = aws_db_subnet_group.default.name
  deletion_protection        = var.db.deletion_protection
  vpc_security_group_ids     = var.security_group
  port                       = var.db.db_port
  tags                       = var.tag_info

  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
}
