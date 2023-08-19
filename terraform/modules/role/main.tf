# 아마존에서 해당 이름으로 생성된 role을 가져온다.
# 완전자동화를 위해, role을 가져오지 않고, 직접 생성하겠다.
# data "aws_iam_role" "get_tw_ec2_codedeploy_role" {
#   name = "ec2-codedeploy-role"
# }

# data "aws_iam_role" "get_tw_codedeploy_service_role" {
#   name = "only-codedeploy"
# }
resource "aws_iam_instance_profile" "aws_ec2_codedeploy_instance_profile" {
  name = var.aws_ec2_codedeploy_instance_profile_name
  role = aws_iam_role.aws_ec2_codedeploy_role.name
}

resource "aws_iam_role" "aws_ec2_codedeploy_role" {
  name = var.aws_ec2_codedeploy_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "aws_ec2_codedeploy_role_attachment" {
  role       = aws_iam_role.aws_ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_role" "aws_codedeploy_service_role" {
  name = var.aws_codedeploy_service_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "aws_codedeploy_service_role_attachment" {
  role       = aws_iam_role.aws_codedeploy_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}