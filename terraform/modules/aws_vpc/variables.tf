variable "vpc_cidr_block" {
  description = "AWS VPC IPV4 CIDR Block"
  type = string
  default = "10.0.0.0/16"
}
variable "vpc_tags_Name" {
  description = "Name of VPC"
  type = string
  default = ""
}
