##########################################################
#               Application Load Balancer                #
##########################################################

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 2.0"

  name = "alb-wordpress"

  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  #[module.vpc.public_subnets[0], module.vpc.public_subnets[1]]


  # Security Group
  security_groups = [aws_security_group.alb_sg.id]

  # ALB Listener
  load_balancer_type = "application"
  https_listener_enabled = "false"
  http_listener_enabled  = "true"

  # Target Group
  target_groups = [
    {
      name        = "tg-http"
      backend_port = 80
      backend_protocol = "HTTP"
      target_type     = "instance"
    }
  ]

  # ALB Listener Rule
  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Owner       = "user"
    Environment = "test"
  }
}


##########################################################
#                   Target Group Attachments             #
##########################################################

resource "aws_lb_target_group_attachment" "primary_instance" {
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = aws_instance.primary_webserver_instance.id
  port             = 80
}


