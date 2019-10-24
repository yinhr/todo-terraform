resource "aws_ecs_cluster" "tododot" {
  name = "tododot"
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "${aws_ecs_cluster.tododot.name}-nginx"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./nginx.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_task_definition" "api" {
  family                   = "${aws_ecs_cluster.tododot.name}-api"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./api.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_service" "nginx" {
  name                              = "tododot-nginx"
  cluster                           = aws_ecs_cluster.tododot.arn
  task_definition                   = aws_ecs_task_definition.nginx.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.nginx_sg.security_group_id]

    subnets = [
      aws_subnet.private_0.id,
      aws_subnet.private_1.id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tododot.arn
    container_name   = "tododot-nginx"
    container_port   = 8000
  }

  lifecycle {
    ignore_changes = ["task_definition"]
  }
}

resource "aws_ecs_service" "api" {
  name             = "tododot-api"
  cluster          = aws_ecs_cluster.tododot.arn
  task_definition  = aws_ecs_task_definition.api.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "1.3.0"

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.api_sg.security_group_id]

    subnets = [
      aws_subnet.private_0.id,
      aws_subnet.private_1.id,
    ]
  }

  service_registries {
    registry_arn = "${aws_service_discovery_service.api.arn}"
  }

  lifecycle {
    ignore_changes = ["task_definition"]
  }
}
