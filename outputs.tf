
output "example_asg_instance_ids" {
  value = aws_autoscaling_group.example_asg.instances[*].instance_id
}