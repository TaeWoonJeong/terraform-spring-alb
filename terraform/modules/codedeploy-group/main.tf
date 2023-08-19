resource "aws_codedeploy_deployment_group" "update_tw_codedeploy_deployment_group" {
  deployment_group_name  = var.codedeploy_deployment_group_name
  app_name               = var.codedeploy_application_name
  service_role_arn       = var.aws_codedeploy_service_role_arn
  deployment_config_name = var.codedeploy_deployment_config_name

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = var.aws_ec2_name
      type  = "KEY_AND_VALUE"
    }
  }
}