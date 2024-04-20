output "s3_bucket_id" {
  description = "ID/Name of S3 Bucket"
  value = aws_s3_bucket.s3_bucket.id
}
output "s3_bucket_arn" {
  description = "ARN of S3 Bucket"
  value = aws_s3_bucket.s3_bucket.arn
}
