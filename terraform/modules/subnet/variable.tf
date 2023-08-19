variable "subnet_cidr_block" {
  description = "subnet을 만들어준다."
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnet_name" {
  description = "subnet 접두사입니다."
  default     = "my-spring-subnet"
}

variable "subnet_availability_zone" {
  description = "subnet 가용영역 입니다. t2.micro를 사용하기 위해 ap-northeast-2a 또는 2c를 사용해야합니다."
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}