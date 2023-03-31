data "aws_availability_zones" "aws_az" {
  state = "available"
}

# data "aws_autoscaling_group" "webserver_asg" {
#   name = aws_autoscaling_group.webserver_asg.name
# }

data "aws_instances" "webserver_asg_instances" {
  instance_tags = {
    "aws:autoscaling:groupName" = aws_autoscaling_group.webserver_asg.name
  }
}
