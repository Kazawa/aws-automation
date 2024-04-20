variable "sp_name" {
  description = "SSM Parameter Name"
  type = string
  default = ""
}
variable "sp_overwrite" {
  description = "SSM Allow or Disallow Overwrite"
  type = bool
  default = false
}
variable "sp_type" {
  description = "SSM Parameter Type"
  type = string
  default = "String"
}
variable "sp_value" {
  description = "SSM Parameter Value"
  type = string
  default = ""
}
