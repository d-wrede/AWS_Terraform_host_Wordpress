resource "aws_db_subnet_group" "DBSubnetGroup" {
  name        = "db-subnet-group"
  description = "Subnets available for the RDS DB Instance"
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
}

resource "aws_rds_cluster" "RDSClusterAurora" {
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.1"
  database_name           = "db"
  master_username         = "admin"
  master_password         = "mysecretpassword"
  skip_final_snapshot     = true
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = [aws_security_group.AuroraSecurityGroup.id]
  db_subnet_group_name    = aws_db_subnet_group.DBSubnetGroup.name
  storage_encrypted       = false
  deletion_protection     = false
  tags = {
    Name = "RDSClusterAurora"
  }
}


resource "aws_rds_cluster_instance" "DBAuroraInstance" {
  identifier            = "db-aurora-instance"
  instance_class        = "db.t3.small"
  engine                = "aurora-mysql"
  engine_version        = "5.7.mysql_aurora.2.11.1"
  cluster_identifier = aws_rds_cluster.RDSClusterAurora.id
  db_subnet_group_name  = aws_db_subnet_group.DBSubnetGroup.name
  tags = {
    Name = "DBAuroraInstance"
  }
}
