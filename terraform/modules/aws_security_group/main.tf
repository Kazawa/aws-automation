resource "aws_security_group" "security_group" {
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = var.security_group_tags_Name
  }
  vpc_id = var.security_group_vpc_id
}
