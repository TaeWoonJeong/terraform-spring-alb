variable "pubic_ec2_instance_type" {
  description = "public ec2 인스턴스 타입입니다."
  default     = "t2.micro"
}

variable "public_ec2_name" {
  description = "public ec2 name 태그 입니다."
  default     = "my-public-ec2"
}