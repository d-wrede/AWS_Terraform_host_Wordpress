output "webserver_ip" {
  value = aws_instance.primary_webserver_instance.public_ip
}

output "example_asg_instance_ids" {
  description = "The instance IDs of the ASG instances"
  value       = data.aws_instances.webserver_asg_instances.ids
}

output "example_asg_instance_ips" {
  description = "The public IPs of the ASG instances"
  value       = data.aws_instances.webserver_asg_instances.public_ips
}

output "alb-wordpress" {
  description = "DNS name of the ALB"
  value       = module.alb.lb_dns_name
}

# output "lb_dns_name" {
#   description = "The DNS name of the load balancer"
#   value       = try(alb.dns_name, "")
# }