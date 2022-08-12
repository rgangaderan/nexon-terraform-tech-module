# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}
# locals use to create subent cidr blocks #
locals {
  az_available_count = length(data.aws_availability_zones.available.names)
  az_count           = min(var.max_azs, var.az_limit, local.az_available_count)
  azs                = [for i in range(local.az_count) : data.aws_availability_zones.available.names[i]]
  cidr_num_bits      = var.cidr_num_bits
  subnet_cidr        = cidrsubnet(var.cidr, local.cidr_num_bits, 1)
  private_cidr       = cidrsubnet(var.cidr, local.cidr_num_bits, 1)
  public_cidr        = cidrsubnet(var.cidr, local.cidr_num_bits, 2)
  private_subnets    = [for i in range(local.az_count) : cidrsubnet(local.private_cidr, 2, i)]
  public_subnets     = [for i in range(local.az_count) : cidrsubnet(local.public_cidr, 2, i)]


  vpc_tag_info = [
    { "key" : "Environment", "value" : "${var.stage}", propagate_at_launch : "true" },
    { "key" : "PlatformOwner", "value" : "${var.name}-${var.stage}", propagate_at_launch : "true" },
    { "key" : "Name", "value" : "${var.name}-${var.stage}", propagate_at_launch : "true" },
  ]

}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.name}-${var.stage}"
  cidr   = var.cidr
  azs    = local.azs

  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = var.single_nat_gateway
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "public"
  }
  private_subnet_tags = {
    Type = "private"
  }
  # Cloudwatch log group and IAM role will be created
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true

  vpc_flow_log_tags = {
    Name = "vpc-flow-logs-cloudwatch-logs"
  }
  tags = local.vpc_tag_info
}
