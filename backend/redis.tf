resource "aws_elasticache_parameter_group" "tododot" {
  name   = "tododot"
  family = "redis5.0"

  parameter {
    name  = "cluster-enabled"
    value = "no"
  }
}

resource "aws_elasticache_subnet_group" "tododot" {
  name       = "tododot"
  subnet_ids = [aws_subnet.private_0.id, aws_subnet.private_1.id]
}

resource "aws_elasticache_replication_group" "tododot" {
  replication_group_id          = "tododot"
  replication_group_description = "redis server for tododot"
  engine                        = "redis"
  engine_version                = "5.0.5"
  number_cache_clusters         = 2
  node_type                     = "cache.t2.micro"
  snapshot_window               = "09:10-10:10"
  maintenance_window            = "mon:10:40-mon:11:40"
  automatic_failover_enabled    = false
  port                          = 6379
  apply_immediately             = false
  security_group_ids            = [module.redis_sg.security_group_id]
  parameter_group_name          = aws_elasticache_parameter_group.tododot.name
  subnet_group_name             = aws_elasticache_subnet_group.tododot.name
}
