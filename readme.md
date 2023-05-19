# AWS Infrastructure with Terraform

This project provisions a scalable and highly available AWS infrastructure using Terraform. The architecture includes a VPC, multi-AZ subnets, EC2 instances, Application Load Balancer (ALB), Auto Scaling Group (ASG), and an RDS Aurora database instance.

## Infrastructure Overview

- **VPC** with its own CIDR block, providing isolation for the resources within.
- Two **Availability Zones (AZs)** for high availability and fault tolerance.
- Each AZ has a **public subnet** hosting the **EC2 instances**, and a **private subnet** hosting the primary and replica **RDS Aurora instances**.
- **EC2 instances** are pre-loaded with a WordPress template and all necessary dependencies (via a `user_data` script), ready for website building.
- **Application Load Balancer (ALB)** distributes incoming application traffic across multiple targets, such as EC2 instances, in multiple Availability Zones.
- **Auto Scaling Group (ASG)** ensures that the number of instances scales up during demand spikes and decreases during demand drops.
- A **stress test tool** is installed on the EC2 instances to test the ALB and ASG.

## Prerequisites

1. You need to have an AWS account.
2. Install Terraform on your local machine.
3. Install AWS CLI and configure it with your AWS account.

## How to use this project

1. Clone this repository to your local machine.

    ```
    git clone git@github.com:d-wrede/AWS_Terraform_host_Wordpress.git
    ```

2. Navigate to the project directory.

    ```
    cd repo
    ```

3. Initialize Terraform. This will download the necessary provider plugins.

    ```
    terraform init
    ```

4. Check what changes will be applied by Terraform.

    ```
    terraform plan
    ```

5. If everything looks good, apply the changes.

    ```
    terraform apply
    ```

6. If you wish to destroy the infrastructure later, you can do so with the following command:

    ```
    terraform destroy
    ```

## Notes

This infrastructure is set up as part of the AWS Cloud Bootcamp. The `user_data` script attached to the EC2 instances installs all necessary packages (like the LAMP stack) and connects to the database.

## Future Work

Future improvements could include the addition of S3 buckets for backups, more comprehensive monitoring and alerting, and additional layers of security such as network access control lists (ACLs).

## Contribution

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
