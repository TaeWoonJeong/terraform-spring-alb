terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  backend "s3" {
    bucket = "tw-spring-alb-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-2"
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source     = "./modules/subnet"
  aws_vpc_id = module.vpc.output_vpc_id
}

module "igw" {
  source     = "./modules/igw"
  aws_vpc_id = module.vpc.output_vpc_id
}

module "key-pair" {
  source = "./modules/key-pair"
}

module "sg" {
  source     = "./modules/sg"
  aws_vpc_id = module.vpc.output_vpc_id
}

module "role" {
  source = "./modules/role"
}

module "public-rt-table" {
  source                     = "./modules/public-rt-table"
  aws_vpc_id                 = module.vpc.output_vpc_id
  aws_default_route_table_id = module.vpc.output_default_route_table_id
  aws_subnet_ids             = module.subnet.output_subnet_ids
  aws_igw_id                 = module.igw.output_igw_id
}

module "public-ec2" {
  source                                   = "./modules/public-ec2"
  aws_key_name                             = module.key-pair.output_key_name
  aws_private_pem                          = module.key-pair.output_private_pem
  aws_subnet_ids                           = module.subnet.output_subnet_ids
  aws_sg_id                                = module.sg.output_default_sg_id
  aws_ec2_codedeploy_instance_profile_name = module.role.output_ec2_codedeploy_instance_profile_name
}

module "codedeploy-group" {
  source                          = "./modules/codedeploy-group"
  aws_ec2_name                    = module.public-ec2.output_public_ec2_name
  aws_codedeploy_service_role_arn = module.role.output_codedeploy_service_role_arn
}

module "alb" {
  source               = "./modules/alb"
  aws_ec2_instance_ids = module.public-ec2.output_public_ec2_instance_ids
  aws_sg_id            = module.sg.output_default_sg_id
  aws_vpc_id           = module.vpc.output_vpc_id
  aws_subnet_ids       = module.subnet.output_subnet_ids
}