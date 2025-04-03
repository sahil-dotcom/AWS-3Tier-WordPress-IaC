
AWS 3-Tier WordPress Architecture using Terraform

## Introduction

This project demonstrates how to deploy a scalable and secure AWS 3-tier architecture to host a WordPress website. The architecture is divided into three distinct layers:
- **Web Layer:** Handles user requests via an Elastic Load Balancer (ELB) and auto-scaled web servers.
- **Application Layer:** Manages business logic using EC2 instances behind an Application Load Balancer (ALB).
- **Data Layer:** Provides persistent storage and database services using Amazon RDS.
Leveraging Terraform for IaC, this project ensures that your infrastructure is reproducible, version-controlled, and easily maintainable.

## Architecture Overview

The AWS 3-Tier architecture consists of:
- **Web Tier:** Auto-scaling groups of EC2 instances behind an ELB.
- **Application Tier:** EC2 instances with an ALB managing inter-tier communication.
- **Database Tier:** Amazon RDS instances with automated backups and replication.

This modular design improves scalability, fault tolerance, and security by isolating different aspects of the application.

## Features

- **Automated Infrastructure Deployment:** Fully deploy the environment with a single Terraform command.
- **Scalable Architecture:** Automatically scale web and application servers based on load.
- **Secure Design:** Separation of concerns with distinct tiers and security group configurations.
- **Reproducible Environment:** Version-controlled infrastructure that can be easily updated or replicated.

Before you begin, ensure you have the following installed:
- [Terraform](https://www.terraform.io/downloads.html) (v0.12 or later)
- An active [AWS Account](https://aws.amazon.com/)
- AWS CLI configured with appropriate credentials
- Git

Configure AWS Credentials:

Ensure your AWS credentials are configured using the AWS CLI or environment variables.

Initialize Terraform:
```bash
terraform init
```
Review and Customize:

Edit the Terraform configuration files to match your environment requirements.

Usage

1. Plan the Deployment:

Run the following command to see the execution plan before applying changes:
```bash
terraform plan
```
2. Deploy the Infrastructure:

Apply the Terraform configuration:
```bash
terraform apply
```
3. Access Your WordPress Site:

Once deployment is complete, retrieve the public DNS or IP from the ELB output and access your WordPress site through a browser.
