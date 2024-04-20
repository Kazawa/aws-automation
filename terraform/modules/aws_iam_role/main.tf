resource "aws_iam_role" "iam_role" {
  name = var.ir_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = var.ir_assume_role_policy_Statement_Action
        Effect = var.ir_assume_role_policy_Statement_Effect
        Sid    = ""
        Principal = {
          Service = var.ir_assume_role_policy_Statement_Principal_Service
        }
      },
    ]
  })

  tags = {
    Name = var.ir_tags_Name
  }
}
