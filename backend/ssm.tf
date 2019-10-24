resource "aws_ssm_parameter" "go111module" {
  name        = "/tododot/go111module"
  value       = "on"
  type        = "String"
  description = "Use Go module"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "echoenv" {
  name        = "/tododot/echoenv"
  value       = "production"
  type        = "String"
  description = "tododot environment"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "dbhost" {
  name        = "/db/host"
  value       = "tmp database host name"
  type        = "SecureString"
  description = "database host name"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "dbport" {
  name        = "/db/port"
  value       = "tmp"
  type        = "SecureString"
  description = "database port"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "dbname" {
  name        = "/db/name"
  value       = "tmp"
  type        = "SecureString"
  description = "database name"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "dbuser" {
  name        = "/db/user"
  value       = "tmp"
  type        = "SecureString"
  description = "database user"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "dbpass" {
  name        = "/db/password"
  value       = "tmp"
  type        = "SecureString"
  description = "database password"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "redishost" {
  name        = "/redis/host"
  value       = "tmp"
  type        = "SecureString"
  description = "redis host name"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "redisport" {
  name        = "/redis/port"
  value       = "tmp"
  type        = "SecureString"
  description = "redis port"

  lifecycle {
    ignore_changes = [value]
  }
}

# change parameter value with aws-cli before deployment
resource "aws_ssm_parameter" "redispass" {
  name        = "/redis/password"
  value       = "tmp"
  type        = "SecureString"
  description = "redis password"

  lifecycle {
    ignore_changes = [value]
  }
}

