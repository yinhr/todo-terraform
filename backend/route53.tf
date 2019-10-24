data "aws_route53_zone" "tododot" {
  name = "tododot.site"
}

resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.tododot.zone_id
  name    = "api.${data.aws_route53_zone.tododot.name}"
  type    = "A"

  alias {
    name                   = aws_lb.tododot.dns_name
    zone_id                = aws_lb.tododot.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cert_validation_api" {
  name    = aws_acm_certificate.api.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.api.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.api.domain_validation_options[0].resource_record_value]
  zone_id = data.aws_route53_zone.tododot.id
  ttl     = 60
}

resource "aws_service_discovery_private_dns_namespace" "tododot" {
  name        = "tododot.local"
  description = "tododot local"
  vpc         = "${aws_vpc.tododot.id}"
}

resource "aws_service_discovery_service" "api" {
  name = "api"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.tododot.id}"

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 3
  }
}

output "domain_name" {
  value = aws_route53_record.api.name
}
