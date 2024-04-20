resource "aws_iam_policy" "iam_policy" {
  description = var.ip_description
  name        = var.ip_name
  path        = var.ip_path
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = var.ip_policy_Statement
  })
}
