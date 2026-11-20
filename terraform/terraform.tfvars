
# General
aws_region  = "eu-west-1"
environment = "dev"

# Networking
vpc_cidr               = "10.0.0.0/16"
public_subnet_1a_cidr  = "10.0.1.0/24"
public_subnet_1b_cidr  = "10.0.2.0/24"
private_subnet_1a_cidr = "10.0.3.0/24"
private_subnet_1b_cidr = "10.0.4.0/24"
availability_zone_1a   = "eu-west-1a"
availability_zone_1b   = "eu-west-1b"

# Application
app_port = 3000

# RDS
db_engine_version    = "16"
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "umami"
db_multi_az          = false

# ECR
ecr_repository_name = "umami"
