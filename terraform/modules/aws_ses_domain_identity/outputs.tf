output "aws_ses_verification_token" {
  value = aws_ses_domain_identity.ses_domain_identity.verification_token
}
