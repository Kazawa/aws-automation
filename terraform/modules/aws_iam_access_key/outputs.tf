output "iam_access_key_id" {
  value = aws_iam_access_key.iam_access_key.id
}
output "iam_access_key_ses_smtp_password_v4" {
  value = aws_iam_access_key.iam_access_key.ses_smtp_password_v4
}
