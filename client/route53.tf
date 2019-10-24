data "aws_route53_zone" "tododot" {
  name = "tododot.site"
}

resource "aws_route53_record" "apex" {
  zone_id = "${data.aws_route53_zone.tododot.zone_id}"
  name    = "${data.aws_route53_zone.tododot.name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.tododot.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.tododot.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.tododot.zone_id}"
  name    = "www.${data.aws_route53_zone.tododot.name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.tododot.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.tododot.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cert_validation_apex" {
  name    = "${aws_acm_certificate.tododot.domain_validation_options[0].resource_record_name}"
  type    = "${aws_acm_certificate.tododot.domain_validation_options[0].resource_record_type}"
  records = ["${aws_acm_certificate.tododot.domain_validation_options[0].resource_record_value}"]
  zone_id = "${data.aws_route53_zone.tododot.id}"
  ttl     = 60
}

resource "aws_route53_record" "cert_validation_www" {
  name    = "${aws_acm_certificate.tododot.domain_validation_options[1].resource_record_name}"
  type    = "${aws_acm_certificate.tododot.domain_validation_options[1].resource_record_type}"
  records = ["${aws_acm_certificate.tododot.domain_validation_options[1].resource_record_value}"]
  zone_id = "${data.aws_route53_zone.tododot.id}"
  ttl     = 60
}
