resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/tododot"
  retention_in_days = 1
}
