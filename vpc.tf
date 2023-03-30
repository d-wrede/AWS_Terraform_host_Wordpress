# Create a VPC
# VPC module
module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  name                    = var.vpc_name
  cidr                    = var.vpc_cidr
  azs                     = data.aws_availability_zones.aws_az.names
  public_subnets          = [var.public_subnet1_cidr, var.public_subnet2_cidr]
  private_subnets         = [var.private_subnet1_cidr, var.private_subnet2_cidr]
  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_hostnames    = true
  enable_dns_support      = true
  tags                    = { 
    Terraform = "true" 
    Environment = "dev"
    }
}
