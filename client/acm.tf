resource "aws_acm_certificate" "tododot" {
  provider                  = "aws.virginia"
  domain_name               = "tododot.site"
  subject_alternative_names = ["www.tododot.site"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "tododot" {
  provider        = "aws.virginia"
  certificate_arn = aws_acm_certificate.tododot.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation_apex.fqdn,
    aws_route53_record.cert_validation_www.fqdn,
  ]
}
