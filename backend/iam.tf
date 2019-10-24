module "ecs_task_execution_role" {
  source     = "./iam"
  name       = "use_ecr"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}
