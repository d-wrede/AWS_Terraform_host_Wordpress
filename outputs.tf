# output "example_asg_instance_ids" {
#   description = "The instance IDs of the ASG instances"
#   value       = [for i in data.aws_autoscaling_group.webserver_asg.instances : i.instance_id]
# }

output "example_asg_instance_ids" {
  description = "The instance IDs of the ASG instances"
  value       = data.aws_instances.webserver_asg_instances.ids
}

