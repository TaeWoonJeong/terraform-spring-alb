resource "aws_default_route_table" "tw_default_public_rt" {
  default_route_table_id = var.aws_default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.aws_igw_id
  }

  tags = {
    Name = var.public_rt_table_name
  }
}
resource "aws_route_table_association" "tw_route_table_association" {
  count          = length(var.aws_subnet_ids)
  subnet_id      = var.aws_subnet_ids[count.index]
  route_table_id = aws_default_route_table.tw_default_public_rt.id
}

resource "aws_main_route_table_association" "tw_main_route_table_association" {
  vpc_id         = var.aws_vpc_id
  route_table_id = aws_default_route_table.tw_default_public_rt.id
}

