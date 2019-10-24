resource "aws_kms_key" "tododot" {
  description             = "tododot customer master key"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "tododot" {
  name          = "alias/tododot"
  target_key_id = aws_kms_key.tododot.id
}
