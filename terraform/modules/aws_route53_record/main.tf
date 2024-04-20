resource "aws_route53_record" "route53_record" {
  name    = var.route53_record_name
  records = var.route53_record_records
  ttl = 600
  type    = var.route53_record_type
  zone_id = var.route53_record_zone_id
}
