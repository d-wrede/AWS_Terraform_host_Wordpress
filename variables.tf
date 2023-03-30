variable "region" {
  description = "The AWS region to use"
  default     = "us-west-2"
}

####################
# VPC variables
####################

variable "vpc_name" {
  description = "Name for the VPC"
  default     = "module_VPC"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.2.0/24"
}

variable "private_subnet1_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.3.0/24"
}

variable "private_subnet2_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.4.0/24"
}

variable "public_subnet1_name" {
  description = "Name for the public subnet"
  default     = "Public subnet 1"
}

variable "public_subnet2_name" {
  description = "Name for the public subnet"
  default     = "Public subnet 2"
}

variable "private_subnet1_name" {
  description = "Name for the public subnet"
  default     = "Private subnet 1"
}

variable "private_subnet2_name" {
  description = "Name for the public subnet"
  default     = "Private subnet 2"
}


variable "cidr_all" {
  description = "CIDR block for the public subnet"
  default     = "0.0.0.0/0"
}

variable "public_route_table_name" {
  description = "Name for the public route table"
  default     = "Public route table"
}

variable "igw_name" {
  description = "Name for the internet gateway"
  default     = "Internet gateway"
}

variable "nat_gateway_name" {
  description = "Name for the NAT gateway"
  default     = "NAT gateway"
}

####################
# Webserver variables
####################

variable "server_instance_name" {
  description = "Name for the instance"
  default     = "Webserver"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instance"
  default     = "ami-0df24e148fdb9f1d8"
}

variable "instance_type" {
  description = "The instance type to use for the instance"
  default     = "t3.micro"
}

variable "key_name" {
  description = "The name of the EC2 key pair to use for SSH access"
  default     = "vockey"
}


####################
# RDS variables
####################

variable "db_subnet_group_name" {
  description = "The name of the RDS subnet group"
  default     = "db-subnet-group"
}

variable "database_name" {
  description = "The name of the database"
  default     = "mydb"
}

variable "master_username" {
  description = "The username of the master user for the database"
  default     = "root"
}

variable "master_password" {
  description = "The password of the master user for the database"
  default     = "password"
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for the database"
  default     = 5
}

variable "preferred_backup_window" {
  description = "The preferred backup window for the database"
  default     = "07:00-09:00"
}

variable "instance_identifier" {
  description = "The identifier for the RDS cluster instance"
  default     = "db-aurora-instance"
}

variable "instance_class" {
  description = "The instance class for the RDS cluster instance"
  default     = "db.t3.small"
}

variable "db_instance_name" {
  description = "The name for the RDS cluster instance"
  default     = "DBAuroraInstance"
}