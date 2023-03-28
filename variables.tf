variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.1.0/24"
}

data "aws_region" "current" {}