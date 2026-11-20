
resource "aws_db_subnet_group" "umami_db_subnet_group" {
  name       = "umami-db-subnet-group"
  subnet_ids = [aws_subnet.umami_private_1a.id, aws_subnet.umami_private_1b.id]

  tags = {
    Name = "umami-db-subnet-group"
  }

}


resource "aws_db_instance" "umami_db" {



  identifier = "umami-db"
  engine     = "postgres"

  engine_version              = "16"
  instance_class              = "db.t3.micro"
  allocated_storage           = 20
  storage_type                = "gp3"
  db_name                     = "umami"
  username                    = "umami"
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.umami_db_subnet_group.name
  vpc_security_group_ids      = [aws_security_group.umami_rds_sg.id]
  publicly_accessible         = false
  multi_az                    = false
  skip_final_snapshot         = true
  deletion_protection         = false

  tags = {
    Name = "umami-db"
  }

}


