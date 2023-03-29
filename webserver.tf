resource "aws_instance" "first_instance" {
  ami           = "ami-0df24e148fdb9f1d8"
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  key_name = "vockey"
  associate_public_ip_address = true
  # read user data from file
  user_data = base64encode(templatefile("${path.module}/user_data.sh", local.vars))
  #user_data = "${file("user_data.sh")}"
  tags = {
    Name = "My super instance"
  }
  depends_on = [aws_rds_cluster_instance.DBAuroraInstance]
}

output "webserver_ip" {
  value = aws_instance.first_instance.public_ip
}