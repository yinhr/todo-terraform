resource "aws_s3_bucket" "alb_log" {
  bucket        = "alb-log-tododot"
  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = "30"
    }
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.alb_log.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.alb_log.id}"]
    }
  }
}
