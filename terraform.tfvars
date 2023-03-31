region = "us-west-2"

####################
# VPC variables
####################

vpc_name = "module_VPC"

vpc_cidr = "10.0.0.0/16"

public_subnet1_cidr = "10.0.1.0/24"

public_subnet2_cidr = "10.0.2.0/24"

private_subnet1_cidr = "10.0.3.0/24"

private_subnet2_cidr = "10.0.4.0/24"

public_subnet1_name = "Public subnet 1"

public_subnet2_name = "Public subnet 2"

private_subnet1_name = "Private subnet 1"

private_subnet2_name = "Private subnet 2"

cidr_all = "0.0.0.0/0"

public_route_table_name = "Public route table"

igw_name = "Internet gateway"

nat_gateway_name = "NAT gateway"

####################
# Webserver variables
####################

server_instance_name = "Webserver"

ami_id = "ami-0df24e148fdb9f1d8"

instance_type = "t3.micro"

key_name = "vockey"

####################
# RDS variables
####################

db_subnet_group_name = "db-subnet-group"

database_name = "mydb"

master_username = "root"

master_password = "password"

backup_retention_period = 5

preferred_backup_window = "07:00-09:00"

instance_identifier = "db-aurora-instance"

instance_class = "db.t3.small"

db_instance_name = "DBAuroraInstance"

########################################
# Application Load Balancer variables
########################################

name_prefix = "alb_"
