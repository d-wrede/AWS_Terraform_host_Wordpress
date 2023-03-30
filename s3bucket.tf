resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "My S3 Bucket"
  }
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.s3"
  route_table_ids     = module.vpc.private_route_table_ids
}

