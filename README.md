AWS 3-Tier WordPress Architecture using Terraform

Overview
This project provisions a 3-Tier AWS Infrastructure to host a WordPress application using Terraform.

Architecture
    Tier 1 (Presentation Layer): Application Load Balancer (ALB) distributes traffic to WordPress instances.
    Tier 2 (Application Layer): Auto Scaling Group (ASG) manages EC2 instances running WordPress.
    Tier 3 (Data Layer): RDS MySQL database stores WordPress data.
    Storage: Amazon EFS for shared WordPress storage.

Backend State Management
The Terraform backend is stored in Amazon S3 for state management and uses DynamoDB for state locking to prevent race conditions.

    S3 Bucket: Stores Terraform state files.
    DynamoDB: Prevents concurrent Terraform operations.

Prerequisites
    Terraform (>= 1.6.0)
    AWS CLI installed & configured
    AWS IAM User with necessary permissions

Setup and Deployment

1. Clone the Repository
2. Initialize Terraform
    terraform init
3. Plan the Deployment
    terraform plan
4. Apply the Configuration
    terraform apply

🚀 Built by Sahil Rahate | DevOps & Cloud Enthusiast