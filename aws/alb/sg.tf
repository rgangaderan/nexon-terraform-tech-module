resource "aws_security_group" "alb_sg" {
  name        = "lb-${local.name_prefix}-sg"
  description = "Allow HTTP from Outside to ALB"
  vpc_id      = var.network.vpc_id
  tags        = var.tag_info
  ingress {
    description = "Allow inbound traffic on port 80 (e.g. http)."
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = var.allowed_ips
  }
  ingress {
    description = "Allow inbound traffic on port 443 (e.g. https)."
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = var.allowed_ips
  }
  egress {
    description = "Allow all outgoing traffic."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
