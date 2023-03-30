resource "aws_instance" "primary_webserver_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  associate_public_ip_address = true
  # read user data from file
  user_data = base64encode(templatefile("${path.module}/user_data.sh", local.vars))
  #user_data = "${file("user_data.sh")}"
  tags = {
    Name = var.server_instance_name
  }
  depends_on = [aws_rds_cluster_instance.DBAuroraInstance]
}

output "webserver_ip" {
  value = aws_instance.first_instance.public_ip
}