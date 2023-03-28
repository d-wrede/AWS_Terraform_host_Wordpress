variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.1.0/24"
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  description = "List of availability zones to use for the subnets"
}