##########################################################
#               Application Load Balancer                #
##########################################################

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "alb-wordpress"
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  # subnets = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]

  # Security Group
  security_groups = [aws_security_group.alb_sg.id]

  # Target Group
  target_groups = [
    {
      name        = "tg-http"
      backend_port = 80
      backend_protocol = "HTTP"
      target_type     = "instance"
      health_check = {
        enabled             = true
        interval            = 120
        path                = "/"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 20
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  ]

  # Attaching the primary webserver instance to the target group
  # targets = {
  #   my_target = {
  #     target_id = aws_instance.primary_webserver_instance.id
  #     port = 80
  #   }
  # }


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

resource "aws_lb_target_group_attachment" "predefined_instance" {
  target_group_arn = module.alb.target_group_arns[0]
  target_id        = aws_instance.primary_webserver_instance.id # Replace with your predefined instance ID
  port             = 80
}