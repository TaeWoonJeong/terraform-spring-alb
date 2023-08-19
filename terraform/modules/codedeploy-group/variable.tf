variable "codedeploy_application_name" {
  description = "codedeploy 어플리케이션 이름입니다."
  default     = "spring-alb-deploy"
}

variable "codedeploy_deployment_group_name" {
  description = "codedeploy 배포그룹 이름입니다."
  default     = "terraform-develop"
}

variable "codedeploy_deployment_config_name" {
  description = "codedeploy 배포그룹의 배포 구성입니다."
  default     = "CodeDeployDefault.AllAtOnce"
}