variable "aws_vpc_id" {
  type = string
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "aws_igw_id" {
  type = string
}

variable "aws_default_route_table_id" {
  type = string
}