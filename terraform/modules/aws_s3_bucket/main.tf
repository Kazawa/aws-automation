resource "aws_s3_bucket" "s3_bucket" {
  bucket_prefix = "${var.sb_bucket_prefix}-"
  
  lifecycle {
    prevent_destroy = false
  }
}
