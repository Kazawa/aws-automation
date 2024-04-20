resource "aws_security_group_rule" "security_group_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = var.security_group_rule_cidr_blocks
  security_group_id = var.security_group_rule_security_group_id
}
