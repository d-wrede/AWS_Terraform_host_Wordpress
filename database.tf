resource "aws_db_subnet_group" "DBSubnetGroup" {
  name        = var.db_subnet_group_name
  description = "Subnets available for the RDS DB Instance"
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
}

resource "aws_rds_cluster" "RDSClusterAurora" {
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.1"
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  skip_final_snapshot     = true
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  vpc_security_group_ids  = [aws_security_group.AuroraSecurityGroup.id]
  db_subnet_group_name    = aws_db_subnet_group.DBSubnetGroup.name
  storage_encrypted       = false
  deletion_protection     = false
  tags = {
    Name = "RDSClusterAurora"
  }
}


resource "aws_rds_cluster_instance" "DBAuroraInstance" {
  identifier            = var.instance_identifier
  instance_class        = var.instance_class
  engine                = "aurora-mysql"
  engine_version        = "5.7.mysql_aurora.2.11.1"
  cluster_identifier    = aws_rds_cluster.RDSClusterAurora.id
  db_subnet_group_name  = aws_db_subnet_group.DBSubnetGroup.name
  tags = {
    Name = var.db_instance_name
  }
}
