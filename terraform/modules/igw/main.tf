resource "aws_internet_gateway" "tw-igw" {
  vpc_id = var.aws_vpc_id

  tags = {
    Name = "${var.igw_prefix}-internet-gateway"
  }
}