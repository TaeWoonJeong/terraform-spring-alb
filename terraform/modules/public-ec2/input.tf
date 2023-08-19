variable "aws_key_name" {
  type = string
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "aws_sg_id" {
  type = string
}

variable "aws_private_pem" {
  type = string
}

variable "aws_ec2_codedeploy_instance_profile_name" {
  type = string
}