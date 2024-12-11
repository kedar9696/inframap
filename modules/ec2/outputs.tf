output "instance_ids" {
  value = aws_instance.server[*].id
}

output "instance_public_ip" {
  description = "The public IP of the webserver instance"
  value       = aws_instance.server[*].public_ip
}

output "instance_name" {
  value = aws_instance.server[*].tags.Name
}

output "instance_tags_all" {
  value = aws_instance.server[*].tags_all
}

output "instance_private_ip" {
  value = aws_instance.server[*].private_ip
}

output "ebs_volume_size" {
  value = aws_instance.server[*].root_block_device[0]
}

output "ebs_volume_type" {
  value = aws_instance.server[*].root_block_device[0].volume_type
}

output "delete_on_terminatione" {
  value = aws_instance.server[*].root_block_device[0].delete_on_termination
}

output "ebs_iops" {
  value = aws_instance.server[*].root_block_device[0].iops
}

output "ebs_throughput" {
  value = aws_instance.server[*].root_block_device[0].throughput
}

output "kms_key_id" {
  value = aws_instance.server[*].root_block_device[0].kms_key_id
}