variable "ir_name" {
  description = "Name of AWS IAM Role"
  type = string
  default = ""
}
variable "ir_assume_role_policy_Statement_Action" {
  description = "Action of the AWS IAM Policy Statement"
  type = string
  default = ""
}
variable "ir_assume_role_policy_Statement_Effect" {
  description = "Effect of the AWS IAM Policy Statement"
  type = string
  default = ""
}
variable "ir_assume_role_policy_Statement_Principal_Service" {
  description = "Principal Service of the AWS IAM Policy Statement"
  type = list
  default = []
}
variable "ir_tags_Name" {
  description = "IAM Role 'Name' Tag"
  type = string
  default = ""
}
