module "smtp_user" {
  source = "../../modules/aws_iam_user"

  iu_name = "smtp_user"
  iu_force_destroy = true
}

module "smtp_access_key" {
  source = "../../modules/aws_iam_access_key"

  iak_user = module.smtp_user.iam_user_name
}

module "smtp_policy" {
  source = "../../modules/aws_iam_policy"

  ip_description = "Send AWS SES Email"
  ip_name = "smtp_email_aws_ses"
  ip_path = "/"
  ip_policy_Statement = [
    {
      "Effect": "Allow",
      "Action": "ses:SendRawEmail",
      "Resource": "*"
    }
  ]  
}

module "smtp_attach_policy" {
  source = "../../modules/aws_iam_user_policy_attachment"

  iupa_user = module.smtp_user.iam_user_name
  iupa_policy_arn = module.smtp_policy.iam_policy_arn
}

module "smtp_id_ssm_parameter" {
  source = "../../modules/aws_ssm_parameter"

  sp_name = "/common/smtp_access_key_id"
  sp_overwrite = true
  sp_type = "SecureString"
  sp_value = module.smtp_access_key.iam_access_key_id
}

module "smtp_pw_ssm_parameter" {
  source = "../../modules/aws_ssm_parameter"

  sp_name = "/common/smtp_password"
  sp_overwrite = true
  sp_type = "SecureString"
  sp_value = module.smtp_access_key.iam_access_key_ses_smtp_password_v4
}
