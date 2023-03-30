############################################################################
#                         Auto Scaling Group                               #
############################################################################

# Launch Configuration
resource "aws_launch_configuration" "webserver_lc" {
  name_prefix = "webserver-lc"
  image_id    = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = base64encode(templatefile("${path.module}/user_data.sh", local.vars))
  security_groups = [aws_security_group.webserver_sg.id]
}


# Auto Scaling Group
resource "aws_autoscaling_group" "webserver_asg" {
  name                      = "webserver-asg"
  launch_configuration      = aws_launch_configuration.webserver_lc.name
  vpc_zone_identifier       = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [module.alb.target_group_arns[0]]

  tags = [
    {
      key                 = "Environment"
      value               = "test"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "Wordpress"
      propagate_at_launch = true
    },
  ]
}

