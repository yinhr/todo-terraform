module "http_sg" {
  source      = "./security_group"
  name        = "http-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source      = "./security_group"
  name        = "https-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "nginx_sg" {
  source      = "./security_group"
  name        = "nginx-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 8000
  cidr_blocks = [aws_vpc.tododot.cidr_block]
}

module "api_sg" {
  source      = "./security_group"
  name        = "api-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 4000
  cidr_blocks = [aws_vpc.tododot.cidr_block]
}

module "mysql_sg" {
  source      = "./security_group"
  name        = "mysql-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 3306
  cidr_blocks = [aws_vpc.tododot.cidr_block]
}

module "redis_sg" {
  source      = "./security_group"
  name        = "redis-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 6379
  cidr_blocks = [aws_vpc.tododot.cidr_block]
}

module "ecr_endpoint_sg" {
  source      = "./security_group"
  name        = "ecr-endpoint-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 443
  cidr_blocks = [aws_subnet.private_0.cidr_block, aws_subnet.private_1.cidr_block]
}

module "logs_endpoint_sg" {
  source      = "./security_group"
  name        = "logs-endpoint-sg"
  vpc_id      = aws_vpc.tododot.id
  port        = 443
  cidr_blocks = [aws_subnet.private_0.cidr_block, aws_subnet.private_1.cidr_block]
}
