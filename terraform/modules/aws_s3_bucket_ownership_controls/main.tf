resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership_controls" {
  bucket = var.s3boc_bucket

  rule {
    object_ownership = var.s3boc_rule_object_ownership
  }
}
