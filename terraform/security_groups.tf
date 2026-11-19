#ALB SECURITY GROUP

resource "aws_security_group" "umami_alb_sg" {
  name        = "umami-alb-sg"
  vpc_id      = aws_vpc.umami_vpc.id
  description = "security group for umami ALB"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  tags = {
    Name = "umami-alb-sg"
  }

}


#ECS Security Group

resource "aws_security_group" "umami_ecs_sg" {
  name        = "umami-ecs-sg"
  vpc_id      = aws_vpc.umami_vpc.id
  description = "security group for umami ECS"

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.umami_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "umami-ecs-sg"
  }

}

#rds security group


resource "aws_security_group" "umami_rds_sg" {

  name        = "umami-rds-sg"
  vpc_id      = aws_vpc.umami_vpc.id
  description = "security group for umami RDS"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.umami_ecs_sg.id]
  }

  egress = []


  tags = {
    Name = "umami-rds-sg"
  }

}