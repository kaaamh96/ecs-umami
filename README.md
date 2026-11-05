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



## Docker Containerization

The Umami application was containerized using Docker to create a consistent and portable deployment environment.

Rather than relying on a prebuilt container image, I developed a custom **multi-stage Dockerfile** to build and package the application for deployment on Amazon ECS Fargate.

### Multi-Stage Docker Build

The Dockerfile uses three main stages:

1. **Dependencies (deps):** Installs the required application dependencies using Node.js and pnpm.
2. **Builder:** Compiles the Umami application and generates the production build.
3. **Runner:** Creates the final runtime image containing the files and dependencies required to run the application.

This approach separates the build environment from the runtime environment, helping reduce unnecessary build dependencies in the final image.

### Container Configuration

The Docker image was configured with the following considerations:

- **Node.js:** Used as the application runtime.
- **Alpine Linux:** Used as a lightweight base image.
- **Multi-stage builds:** Separated dependency installation, application compilation, and runtime execution.
- **Non-root user:** Configured the container to run with reduced privileges.
- **Port 3000:** Exposed the port used by the Umami application.
- **Environment variables:** Used to configure application settings and database connectivity.
- **ARM64 architecture:** Built the image for compatibility with the ECS Fargate task definition.

### Building and Publishing the Image

The container image was built using Docker Buildx and pushed to Amazon Elastic Container Registry (ECR).

The following command demonstrates the build and push process:

```bash
docker buildx build \
  --platform linux/arm64 \
  -t <account-id>.dkr.ecr.eu-west-1.amazonaws.com/umami:latest \
  --push .
```

The command performs the following operations:

- `docker buildx build` builds the container image using the Dockerfile.
- `--platform linux/arm64` specifies the target CPU architecture.
- `-t` assigns the image tag and ECR repository destination.
- `--push` uploads the resulting image to Amazon ECR.
- `.` specifies the current directory as the Docker build context.

The image was subsequently referenced by the ECS task definition and deployed using AWS Fargate.



## AWS Deployment Process

The Umami application was deployed manually using the AWS Management Console. This initial deployment focused on understanding how AWS services integrate before introducing Infrastructure as Code (Terraform) and CI/CD automation.

The deployment was carried out in the **Europe (Ireland) region (`eu-west-1`)**.

### 1. Network Infrastructure

A dedicated VPC was created to provide an isolated network environment for the application.

The network configuration included:

- A VPC spanning two Availability Zones.
- Two public subnets for the Application Load Balancer and NAT Gateways.
- Two private subnets for the application and database resources.
- An Internet Gateway for public internet connectivity.
- Two NAT Gateways to provide outbound internet access from private subnets.
- Route tables configured to direct traffic through the appropriate gateways.
- Security groups restricting access between the ALB, ECS tasks, and RDS database.

### 2. Database Configuration

An Amazon RDS PostgreSQL database was provisioned to store Umami application data.

- The database was deployed without public accessibility.
- A security group allowed PostgreSQL traffic on port `5432` from the ECS task security group.
- Database credentials were stored in AWS Secrets Manager.
- The ECS application accessed the database using a connection string supplied through its task configuration.

### 3. Container Registry

An Amazon ECR repository was created to store the Umami Docker image.

The custom Docker image was built for the `linux/arm64` platform using Docker Buildx and pushed to ECR.

This image was subsequently used by the ECS task definition.

### 4. ECS Fargate Configuration

An ECS cluster, task definition, and service were created to run the containerized application.

The task definition specified:

- AWS Fargate as the launch type.
- Linux/ARM64 as the runtime platform.
- The Docker image hosted in Amazon ECR.
- Container port `3000`.
- Application secrets retrieved from AWS Secrets Manager.
- Amazon CloudWatch Logs for application logging.

The ECS service was configured to run the application within private subnets and register its tasks with an Application Load Balancer target group.

### 5. Application Load Balancer

An internet-facing Application Load Balancer was deployed across two public subnets.

- An HTTP listener was configured on port `80`.
- A target group was configured to forward traffic to ECS tasks on port `3000`.
- Health checks were configured using the `/health` endpoint.
- Security groups restricted application traffic to requests originating from the ALB.

### 6. Deployment Verification

After resolving initial deployment issues, the ECS service successfully started the Umami application.

Deployment was verified by:

- Checking ECS task status.
- Reviewing application startup logs in Amazon CloudWatch.
- Confirming that the ALB target group reported a healthy target.
- Accessing the application through the ALB DNS address.
- Successfully logging into the Umami dashboard.

Following successful testing and documentation, the AWS resources were deleted to avoid unnecessary ongoing charges.




## Troubleshooting and Solutions

During the containerization and deployment of Umami, several technical challenges were encountered. Troubleshooting these issues provided practical experience with Docker, Amazon ECS, AWS Secrets Manager, PostgreSQL, and application networking.

### 1. Docker Build and Runtime Issues

| Issue | Cause | Resolution |
|-------|-------|------------|
| Missing runtime dependency | The container failed with `ERR_MODULE_NOT_FOUND` because the `dotenv` package was unavailable at runtime. | Added the required dependencies to the Dockerfile runner stage. |
| Large Docker image | An earlier Docker image was approximately 2.14 GB. | Reviewed the multi-stage Dockerfile and optimized the runtime image, reducing its size to approximately 467 MB. |

### 2. Amazon ECS Deployment Issues

| Issue | Cause | Resolution |
|-------|-------|------------|
| CPU architecture mismatch | The Docker image was built for ARM64, while the ECS task definition initially used X86_64. | Updated the ECS task definition to use Linux/ARM64. |
| Secrets Manager reference error | ECS could not retrieve the database connection string because the secret reference was incorrectly formatted. | Corrected the Secrets Manager ARN reference in the ECS task definition. |
| PostgreSQL encryption error | The application could not establish a database connection because RDS required an encrypted connection. | Updated the database connection configuration to enable SSL. |
| TLS certificate verification error | The application encountered a `self-signed certificate in certificate chain` error when connecting to RDS. | Temporarily configured `sslmode=no-verify` to complete deployment testing. Proper certificate verification remains a security improvement to implement. |
| Container hostname resolution failure | The Next.js server failed with `getaddrinfo ENOTFOUND` when attempting to resolve the container hostname. | Updated the Dockerfile startup command to explicitly set `HOSTNAME=0.0.0.0`. |
| ECS not using updated Docker image | Pushing a new image to ECR with the same `latest` tag did not automatically update the running ECS tasks. | Forced a new ECS service deployment to launch tasks using the updated image. |

### 3. Resolving the Container Hostname Error

One of the most challenging deployment issues involved the Next.js application failing to start correctly inside the ECS Fargate container.

The application produced the following error:

```text
getaddrinfo ENOTFOUND
```

Initially, the `HOSTNAME` environment variable was configured in the Dockerfile, but this did not resolve the issue.

The final solution was to explicitly set the hostname within the container startup command:

```dockerfile
CMD ["sh", "-c", "export HOSTNAME=0.0.0.0; exec sh scripts/start-docker.sh"]
```

This allowed the Next.js server to bind to `0.0.0.0`, making it accessible through the ECS task network interface.

After rebuilding the Docker image, pushing it to Amazon ECR, and forcing a new ECS deployment, the application started successfully.

### 4. Deployment Outcome

After resolving the deployment issues:

- The ECS Fargate task started successfully.
- The application connected to the Amazon RDS PostgreSQL database.
- Database initialization and migrations completed successfully.
- Amazon CloudWatch logs confirmed successful application startup.
- The Application Load Balancer target became healthy.
- The Umami login page and dashboard were accessible through the ALB.

These challenges strengthened my understanding of container runtime environments, CPU architecture compatibility, database connectivity, AWS networking, and troubleshooting distributed cloud applications.

**Security Note:** The temporary `sslmode=no-verify` configuration was used to unblock deployment testing. It does not provide proper database certificate verification and will be replaced with a trusted RDS CA configuration during the next deployment phase.



