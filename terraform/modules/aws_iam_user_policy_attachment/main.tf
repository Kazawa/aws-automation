resource "aws_iam_user_policy_attachment" "iam_user_policy_attachment" {
  user       = var.iupa_user
  policy_arn = var.iupa_policy_arn
}
