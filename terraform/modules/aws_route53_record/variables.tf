variable "route53_record_name" {
  description = "R53 Record Name"
  type = string
  default = ""
}
variable "route53_record_records" {
  description = "R53 Record Value(s)"
  type = list
  default = []
}
variable "route53_record_type" {
  description = "R53 Record Type"
  type = string
  default = ""
}
variable "route53_record_zone_id" {
  description = "R53 Zone ID"
  type = string
  default = ""
}
