variable "vpc_cidr_block" {
  description = "vpc IPv4 CIDR 블록입니다."
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "vpc 이름입니다."
  default     = "my-vpc-01"
}