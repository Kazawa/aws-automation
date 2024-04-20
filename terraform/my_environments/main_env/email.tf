module "aws_ses_gltest" {
  source = "../../modules/aws_ses_domain_identity"
  
  sdi_domain = data.aws_route53_zone.route53_zone_gltest.name  
}

# This is the old way of verifying records.  DKIM Verification is all you need.
#module "aws_ses_verification_record_gltest" {
#  source = "../../modules/aws_route53_record"

#  # This particular name must start with an '_' maybe even '_awsses'...
#  route53_record_name = "_amazonses"
#  route53_record_records = [module.aws_ses_gltest.aws_ses_verification_token]
#  route53_record_type = "TXT"
#  route53_record_zone_id = data.aws_route53_zone.route53_zone_gltest.zone_id
#}

module "aws_ses_dkim_gltest" {
  source = "../../modules/aws_ses_domain_dkim"

  sdd_domain = data.aws_route53_zone.route53_zone_gltest.name
}

module "aws_ses_dkim_verification_records_gltest" {
  source = "../../modules/aws_route53_record"
  count = 3
  
  # These names and records most likely have to end in the values set. Unsure.
  route53_record_name = "${module.aws_ses_dkim_gltest.aws_ses_dkim_tokens[count.index]}._domainkey"
  route53_record_records = ["${module.aws_ses_dkim_gltest.aws_ses_dkim_tokens[count.index]}.dkim.amazonses.com"]
  route53_record_type = "CNAME"
  route53_record_zone_id = data.aws_route53_zone.route53_zone_gltest.zone_id
}
