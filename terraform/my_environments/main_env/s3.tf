module "s3_bucket" {
  source = "../../modules/aws_s3_bucket"

  sb_bucket_prefix = "${var.db_company}"
}

module "s3_bucket_ssm_parameter" {
  source = "../../modules/aws_ssm_parameter"

  sp_name = "/${var.db_company}/s3_bucket"
  sp_overwrite = true
  sp_type = "String"
  sp_value = module.s3_bucket.s3_bucket_id
}

module "s3_bucket_ownership_controls" {
  source = "../../modules/aws_s3_bucket_ownership_controls"

  s3boc_bucket = module.s3_bucket.s3_bucket_id
  s3boc_rule_object_ownership = "BucketOwnerEnforced"
}

module "s3_bucket_public_access_block" {
  source = "../../modules/aws_s3_bucket_public_access_block"

  s3bpab_bucket = module.s3_bucket.s3_bucket_id
}

module "s3_bucket_server_side_encryption_configuration" {
  source = "../../modules/aws_s3_bucket_server_side_encryption_configuration"

  s3bssec_bucket = module.s3_bucket.s3_bucket_id
}
