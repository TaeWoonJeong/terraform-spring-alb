variable "aws_ec2_codedeploy_instance_profile_name" {
  description = "ec2_codedeploy_instance_profile_name 입니다."
  default     = "terraform_ec2_codedeploy_instance_profile"
}

variable "aws_ec2_codedeploy_role_name" {
  description = "aws_ec2_codedeploy_role_name 입니다."
  default     = "terraform_ec2_codedeploy_role"
}

variable "aws_codedeploy_service_role_name" {
  description = "aws_codedeploy_service_role_name 입니다."
  default     = "terraform_codedeploy_service_role"
}