resource "aws_db_parameter_group" "tododot" {
  name   = "tododot"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
}

resource "aws_db_subnet_group" "tododot" {
  name       = "tododot"
  subnet_ids = [aws_subnet.private_0.id, aws_subnet.private_1.id]
}

resource "aws_db_instance" "tododot" {
  identifier                 = "tododot"
  name                       = "tododot"
  engine                     = "mysql"
  engine_version             = "8.0.16"
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  max_allocated_storage      = 1000
  storage_type               = "gp2"
  storage_encrypted          = true
  kms_key_id                 = aws_kms_key.tododot.arn
  username                   = "docker"
  password                   = "ppaasssswwoorrdd"
  multi_az                   = false
  backup_window              = "09:10-09:40"
  backup_retention_period    = 2
  maintenance_window         = "mon:10:10-mon:10:40"
  auto_minor_version_upgrade = false
  skip_final_snapshot        = true
  port                       = 3306
  apply_immediately          = false
  vpc_security_group_ids     = [module.mysql_sg.security_group_id]
  parameter_group_name       = aws_db_parameter_group.tododot.name
  db_subnet_group_name       = aws_db_subnet_group.tododot.name

  lifecycle {
    ignore_changes = [password]
  }
}
