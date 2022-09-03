locals {
  name_prefix = "${var.name}-${var.stage}"
}

resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  number  = false
}

#####################################################
# DB Subnet Group
#####################################################
resource "aws_db_subnet_group" "default" {
  name       = "${local.name_prefix}-${random_string.random.result}"
  subnet_ids = var.private_subnet_ids

  tags = var.tag_info
}

#####################################################
# RDS Instance
#####################################################
resource "aws_db_instance" "database" {
  identifier             = "${local.name_prefix}-${random_string.random.result}"
  allocated_storage      = var.db.storage
  engine                 = var.db.engine
  engine_version         = var.db.engine_version
  instance_class         = var.db.instance_class
  name                   = var.db.database_name
  username               = var.database_username
  password               = var.database_password
  parameter_group_name   = var.db.parameter_group_name
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
  deletion_protection    = var.db.deletion_protection
  vpc_security_group_ids = var.security_group
  port                   = var.db.db_port
  tags                   = var.tag_info
}
