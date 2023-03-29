resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "Allow webserver and ssh traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_all]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_all]
  }

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "AuroraSecurityGroup" {
  name_prefix = "aurora_communication"
  description = "Allow communication with Aurora"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id]
    #security_group_id = aws_security_group.webserver_sg.id
  }

  egress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id]
  }
}

