output "aws_ses_dkim_tokens" {
  value = aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens
}
