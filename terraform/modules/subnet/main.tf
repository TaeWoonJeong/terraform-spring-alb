resource "aws_subnet" "tw_subnet" {
  count             = length(var.subnet_availability_zone)
  vpc_id            = var.aws_vpc_id
  cidr_block        = var.subnet_cidr_block[count.index]
  availability_zone = var.subnet_availability_zone[count.index]

  tags = {
    Name = var.subnet_name
  }
}