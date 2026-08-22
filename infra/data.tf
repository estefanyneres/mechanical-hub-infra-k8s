data "aws_vpc" "base" {
  filter {
    name   = "tag:Name"
    values = [var.projectName]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.base.id]
  }

  tags = {
    Tier = "public"
  }
}

data "aws_security_group" "app" {
  filter {
    name   = "tag:Name"
    values = ["${var.projectName}-app-sg"]
  }
}

data "aws_security_group" "rds" {
  filter {
    name   = "tag:Name"
    values = ["${var.projectName}-rds-sg"]
  }
}

data "aws_security_group" "alb" {
  filter {
    name   = "tag:Name"
    values = ["${var.projectName}-alb-sg"]
  }
}
