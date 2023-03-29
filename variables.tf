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