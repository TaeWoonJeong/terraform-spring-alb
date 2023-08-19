output "output_vpc_id" {
  description = "만든 vpc id를 내보냅니다."
  value       = aws_vpc.tw_vpc.id
}

output "output_default_route_table_id" {
  description = "vpc 에서 자동으로 생성한 route table id를 내보냅니다."
  value       = aws_vpc.tw_vpc.default_route_table_id
}