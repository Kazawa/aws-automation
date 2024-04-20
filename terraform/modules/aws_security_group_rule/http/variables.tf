variable "security_group_rule_security_group_id" {
  description = "HTTP SG ID"
  type = string
  default = ""
}
variable "security_group_rule_cidr_blocks" {
  description = "SG CIDR Block"
  type = list
  default = ["0.0.0.0/0"]
}
