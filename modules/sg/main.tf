resource "aws_security_group" "ec2" {
  name   = "${var.projectname}-ec2-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.projectname}-ec2-sg"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http" {
  security_group_id            = aws_security_group.ec2.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_ingress_rule" "ec2_https" {
  security_group_id            = aws_security_group.ec2.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ssh" {
  security_group_id            = aws_security_group.ec2.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eic.id
}

resource "aws_vpc_security_group_egress_rule" "ec2" {
  security_group_id = aws_security_group.ec2.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}


resource "aws_security_group" "eic" {
  name   = "${var.projectname}-eic"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.projectname}-eic"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_egress_rule" "eic" {
  security_group_id = aws_security_group.eic.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.vpc_cidr
}

resource "aws_security_group" "efs" {
  name   = "${var.projectname}-efs-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.projectname}-efs-sg"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "efs" {
  security_group_id            = aws_security_group.efs.id
  from_port                    = 2049
  to_port                      = 2049
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.ec2.id
}

resource "aws_vpc_security_group_egress_rule" "efs" {
  security_group_id = aws_security_group.efs.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "rds" {
  name   = "${var.projectname}-rds-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.projectname}-rds-sg"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds" {
  security_group_id            = aws_security_group.rds.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group" "alb" {
  name   = "${var.projectname}-alb-sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.projectname}-alb-sg"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
