variable "iu_name" {
  description = "AWS IAM User Name"
  type = string
  default = ""
}
variable "iu_force_destroy" {
  description = "AWS IAM Force Destroy User"
  type = bool
  default = false
}
