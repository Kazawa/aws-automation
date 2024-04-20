variable "ip_description" {
  description = "IAM Policy Description"
  type = string
  default = ""
}
variable "ip_name" {
  description = "IAM Policy Name"
  type = string
  default = ""
}
variable "ip_path" {
  description = "IAM Policy Path"
  type = string
  default = ""
}
variable "ip_policy_Statement" {
  description = "IAM Policy Statements"
  type = list
  default = []
}
