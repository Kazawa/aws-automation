resource "aws_ssm_parameter" "ssm_parameter" {
  name  = var.sp_name
  overwrite = var.sp_overwrite
  type  = var.sp_type
  value = var.sp_value
}
