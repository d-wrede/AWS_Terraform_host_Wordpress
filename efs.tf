################################################################################
# EFS - Elastic File System
################################################################################

resource "aws_efs_file_system" "efs_fs" {
  creation_token = "my-efs-fs"
  encrypted      = true
  performance_mode = "generalPurpose"

  tags = {
    Name = "My EFS File System"
  }
}

resource "aws_efs_mount_target" "efs_mt1" {
  file_system_id = aws_efs_file_system.efs_fs.id
  subnet_id      = module.vpc.private_subnets[0]

  security_groups = [
    aws_security_group.efs_sg.id
  ]
}

resource "aws_efs_mount_target" "efs_mt2" {
  file_system_id = aws_efs_file_system.efs_fs.id
  subnet_id      = module.vpc.private_subnets[1]

  security_groups = [
    aws_security_group.efs_sg.id
  ]
}

resource "aws_security_group" "efs_sg" {
  name_prefix = "efs_sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
