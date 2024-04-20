resource "aws_iam_role_policy" "iam_role_policy" {
  name = var.irp_name
  role = var.irp_role

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = var.irp_policy_Statement
  })
}
