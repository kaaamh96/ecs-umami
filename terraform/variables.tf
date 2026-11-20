
# ==========================================
# General Configuration
# ==========================================

variable "aws_region" {
  description = "AWS region for deploying resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

# ==========================================
# VPC and Subnets
# ==========================================

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1a_cidr" {
  description = "CIDR block for public subnet in AZ 1a"
  type        = string
}

variable "public_subnet_1b_cidr" {
  description = "CIDR block for public subnet in AZ 1b"
  type        = string
}

variable "private_subnet_1a_cidr" {
  description = "CIDR block for private subnet in AZ 1a"
  type        = string
}

variable "private_subnet_1b_cidr" {
  description = "CIDR block for private subnet in AZ 1b"
  type        = string
}

variable "availability_zone_1a" {
  description = "First availability zone"
  type        = string
}

variable "availability_zone_1b" {
  description = "Second availability zone"
  type        = string
}

# ==========================================
# Application
# ==========================================

variable "app_port" {
  description = "Port used by the Umami application"
  type        = number
}

# ==========================================
# RDS PostgreSQL
# ==========================================

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated RDS storage in GB"
  type        = number
}

variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment for RDS"
  type        = bool
}

# ==========================================
# ECR
# ==========================================

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}
