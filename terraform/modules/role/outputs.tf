output "output_ec2_codedeploy_instance_profile_name" {
  value = aws_iam_instance_profile.aws_ec2_codedeploy_instance_profile.name
}

output "output_codedeploy_service_role_arn" {
  value = aws_iam_role.aws_codedeploy_service_role.arn
}