variable "irp_name" {
  description = "IAM Policy Name"
  type = string
  default = ""
}
variable "irp_role" {
  description = "ID of Role to Attach Policy"
  type = string
  default = ""
}
variable "irp_policy_Statement"{
  description = "List of Policy Actions"
  type = list
}
