resource "aws_ecr_repository" "nginx" {
  name = "tododot-nginx"
}

resource "aws_ecr_repository" "api" {
  name = "tododot-api"
}

