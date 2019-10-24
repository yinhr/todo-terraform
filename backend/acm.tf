resource "aws_acm_certificate" "api" {
  domain_name               = "api.tododot.site"
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "api" {
  certificate_arn = aws_acm_certificate.api.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation_api.fqdn,
  ]
}
