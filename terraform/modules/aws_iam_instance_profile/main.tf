resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.iip_name
  role = var.iip_role
  tags = {
    "Name" = "${var.iip_tags_Name}-Instance-Profile"
  }
}
