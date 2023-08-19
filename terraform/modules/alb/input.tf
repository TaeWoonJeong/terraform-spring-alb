variable "aws_sg_id" {
  type = string
}

variable "aws_vpc_id" {
  type = string
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "aws_ec2_instance_ids" {
  type = list(string)
}