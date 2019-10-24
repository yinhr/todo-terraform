resource "aws_s3_bucket" "cloudfront_origin" {
  bucket        = "tododot-cloudfront-origin"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "cloudfront_origin" {
  bucket = aws_s3_bucket.cloudfront_origin.id
  policy = data.aws_iam_policy_document.cloudfront_origin.json
}

data "aws_iam_policy_document" "cloudfront_origin" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.cloudfront_origin.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}
