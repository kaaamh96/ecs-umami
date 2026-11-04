# Deploying Umami Analytics on AWS Fargate

 
## Project Overview

This project demonstrates the containerization and deployment of **Umami**, an open-source web analytics application, using **Amazon ECS with AWS Fargate**.

The application was containerized using Docker and deployed on AWS using a multi-tier architecture. The infrastructure includes Amazon ECR for container image storage, an Application Load Balancer (ALB) for routing incoming traffic, and Amazon RDS for PostgreSQL database hosting.

The objective of this project was to gain hands-on experience with Docker, AWS networking, container orchestration, database connectivity, and cloud security by deploying a real-world application.

The application was successfully deployed, tested, and accessed through the load balancer.



## Project Objectives

The main objectives of this project were to:

- Containerize the Umami application using a multi-stage Dockerfile.
- Build and push a Docker image to Amazon Elastic Container Registry (ECR).
- Deploy and manage the containerized application using Amazon ECS with AWS Fargate.
- Design a secure AWS network architecture using a VPC, public and private subnets, route tables, and security groups.
- Configure an Application Load Balancer (ALB) to distribute incoming traffic and perform health checks.
- Deploy an Amazon RDS PostgreSQL database for persistent application data.
- Securely manage application credentials using AWS Secrets Manager.
- Monitor application logs and troubleshoot deployment issues using Amazon CloudWatch.
- Gain practical experience deploying, testing, and managing a real-world application in AWS.


## Technologies Used

| Technology | Purpose |
|------------|---------|
| Docker | Containerized the Umami application using a multi-stage Dockerfile |
| Amazon ECR | Stored the Docker container image |
| Amazon ECS (Fargate) | Ran and managed the containerized application |
| Amazon VPC | Provided an isolated network environment |
| Application Load Balancer | Routed HTTP traffic to the ECS application |
| Amazon RDS (PostgreSQL) | Hosted the application's relational database |
| AWS Secrets Manager | Managed application credentials and secrets |
| Amazon CloudWatch | Collected application logs for monitoring and troubleshooting |
| AWS IAM | Managed permissions for AWS resources |
| Git & GitHub | Version control and project documentation |



## AWS Architecture

The application was deployed using a multi-tier AWS architecture designed to separate public-facing resources from private application and database resources.

The infrastructure was deployed in the AWS Europe (Ireland) region (`eu-west-1`) across two Availability Zones.

### Network Architecture

- **VPC:** A dedicated Virtual Private Cloud provided an isolated network environment.
- **Public Subnets:** Two public subnets hosted the internet-facing Application Load Balancer and NAT Gateways.
- **Private Subnets:** Two private subnets hosted the ECS Fargate application tasks.
- **Internet Gateway:** Enabled internet connectivity for public resources.
- **NAT Gateways:** Two NAT Gateways provided outbound internet access for resources in private subnets.
- **Route Tables:** Controlled traffic routing between subnets and gateways.
- **Security Groups:** Restricted network traffic between the ALB, ECS tasks, and RDS database.

### Application and Database Architecture

- **Amazon ECR:** Stored the containerized Umami application image.
- **Amazon ECS with Fargate:** Ran the application containers without requiring EC2 server management.
- **Application Load Balancer:** Received HTTP requests and forwarded them to healthy ECS tasks on port 3000.
- **Amazon RDS:** Hosted the PostgreSQL database in a private network environment.
- **AWS Secrets Manager:** Stored sensitive application configuration values.
- **Amazon CloudWatch:** Collected application logs to support monitoring and troubleshooting.

### Application Traffic Flow

1. A user accesses the application through the public Application Load Balancer.
2. The ALB forwards the request to a healthy ECS Fargate task on port 3000.
3. The Umami application communicates with the PostgreSQL database hosted on Amazon RDS.
4. The application returns the response to the user through the ALB.


### Architecture Diagram


<img width="1536" height="1024" alt="Umami ECS DIAGRAM" src="https://github.com/user-attachments/assets/06b6b3e9-e597-4ae8-b1c6-7a4be207bf14" />



