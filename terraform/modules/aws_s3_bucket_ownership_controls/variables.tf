variable "s3boc_bucket" {
  description = "Bucket ID"
  type = string
  default = ""
}
variable "s3boc_rule_object_ownership" {
  description = "S3 Object Ownership Declaration"
  type = string
  default = "BucketOwnerEnforced"
}
