output "output_public_ec2_name" {
  description = "ec2 이름입니다."
  value       = var.public_ec2_name
}

output "output_public_ec2_instance_ids" {
  value = aws_instance.tw_instance[*].id
}