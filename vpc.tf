# Create a VPC
# VPC module
module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  name                    = var.vpc_name
  cidr                    = var.vpc_cidr
  azs                     = data.aws_availability_zones.aws_az.names
  private_subnets         = [var.private_subnet1_cidr, var.private_subnet2_cidr]
  public_subnets          = [var.public_subnet1_cidr, var.public_subnet2_cidr]
  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_hostnames    = true
  tags                    = { 
    Terraform = "true" 
    Environment = "dev"
    }
}
# resource "aws_vpc" "myvpc" {
#   cidr_block = var.vpc_cidr
#   tags = {
#     Name = var.vpc_name
#   }
# }


# resource "aws_subnet" "public_subnet1" {
#   vpc_id     = aws_vpc.myvpc.id
#   cidr_block = var.public_subnet1_cidr

#   tags = {
#     Name = var.public_subnet1_name
#   }
# }

# resource "aws_subnet" "private_subnet1" {
#   vpc_id     = aws_vpc.myvpc.id
#   cidr_block = var.private_subnet1_cidr

#   tags = {
#     Name = var.private_subnet1_name
#   }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.myvpc.id

#   tags = {
#     Name = var.igw_name
#   }
# }

# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.myvpc.id
#   route {
#     cidr_block = var.cidr_all
#     gateway_id = aws_internet_gateway.igw.id
#   }
#   tags = {
#     Name = var.public_route_table_name
#   }
# }

# resource "aws_route_table_association" "subnet_association_public" {
#   subnet_id      = aws_subnet.public_subnet1.id
#   route_table_id = aws_route_table.public_route_table.id
# }

# resource "aws_eip" "nat_gateway" {
#   vpc = true
# }

# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.nat_gateway.id
#   subnet_id     = aws_subnet.private_subnet1.id
#   tags = {
#     "Name" = var.nat_gateway_name
#   }
# }

# resource "aws_route_table" "route_table_private" {
#   vpc_id = aws_vpc.myvpc.id
#   route {
#     cidr_block     = var.cidr_all
#     nat_gateway_id = aws_nat_gateway.nat_gateway.id
#   }
# }

# resource "aws_route_table_association" "subnet_association_private" {
#   subnet_id      = aws_subnet.private_subnet1.id
#   route_table_id = aws_route_table.route_table_private.id
# }

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_all]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# output "nat_gateway_ip" {
#   value = aws_eip.nat_gateway.public_ip
# }
