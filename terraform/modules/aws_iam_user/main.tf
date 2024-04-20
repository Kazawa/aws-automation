resource "aws_iam_user" "iam_user" {
  name = var.iu_name
  force_destroy = var.iu_force_destroy
}
