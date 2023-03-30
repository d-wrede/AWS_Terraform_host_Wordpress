locals {
  vars = {
    dbendpoint = aws_rds_cluster.RDSClusterAurora.endpoint
  }
}
